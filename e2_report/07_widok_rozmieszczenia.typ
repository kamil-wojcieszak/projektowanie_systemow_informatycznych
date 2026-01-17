= Widok rozmieszczenia

== Diagram rozmieszczenia

#figure(
  image("images/architektura-aws.png", width: 100%),
  caption: [Diagram rozmieszczenia systemu]
)

== Opis architektury systemu

System zbudowany jest w oparciu o architekturę mikroserwisową, wykorzystującą usługi AWS. Całość została podzielona na dwa główne obszary: Frontend oraz API.

=== Warstwa Frontend

Warstwa Frontend obejmuje:

- *Route 53* - usługa DNS AWS, która kieruje ruch użytkowników do odpowiednich zasobów
- *Frontend CloudFront* - sieć CDN (Content Delivery Network) zapewniająca szybki dostęp do zasobów statycznych aplikacji frontendowej
- *Bucket* - kontener S3 przechowujący statyczne pliki aplikacji frontendowej (HTML, CSS, JavaScript)
- *UI* - interfejs użytkownika zbudowany w technologii React

Warstwa ta jest odpowiedzialna za prezentację danych użytkownikowi końcowemu oraz obsługę interakcji.

=== Warstwa API

Warstwa API składa się z następujących komponentów:

- *API CloudFront* - sieć CDN cachująca odpowiedzi API i zmniejszająca opóźnienia
- *API Gateway* - centralny punkt wejściowy do wszystkich mikroserwisów, zarządzający routingiem żądań, autoryzacją oraz ograniczeniami ruchu

==== Mikroserwisy (Lambda Functions)

System wykorzystuje funkcje Lambda, które realizują różne funkcjonalności biznesowe:

- *Auth Lambda* - obsługa uwierzytelniania i autoryzacji użytkowników, połączona z bazą danych Account Database
- *Showroom and Service Lambda* - zarządzanie ekspozycją pojazdów, prezentacją oferty oraz usługami serwisowymi i naprawami, współdzieląca bazę danych Showroom and Service Database
- *Shop Lambda* - obsługa procesów związanych ze sprzedażą i transakcjami, z dostępem do Shop Database oraz integracja z zewnętrznym dostawcą płatności (tpay)

=== Warstwa danych

System wykorzystuje rozdzielone bazy danych dla poszczególnych obszarów funkcjonalnych:

- *Account Database* - przechowuje dane użytkowników, informacje o kontach i uprawnieniach. Dedykowana dla funkcji Auth Lambda
- *Showroom and Service Database* - wspólna baza danych dla funkcjonalności związanych z wystawą pojazdów oraz serwisem. Zawiera informacje o pojazdach w showroomie, historię serwisową, zlecenia napraw i szczegóły usług
- *Shop Database* - przechowuje dane transakcyjne, zamówienia, koszyki zakupowe oraz historię zakupów klientów

==== Integracje zewnętrzne

- *Third Party Payment Provider (tpay)* - zewnętrzny system płatności zintegrowany z Shop Lambda, obsługujący transakcje finansowe, weryfikację płatności oraz zwroty

=== Komunikacja między komponentami

System charakteryzuje się następującym przepływem danych:

1. Użytkownik łączy się przez Route 53, który kieruje ruch do Frontend CloudFront
2. Frontend CloudFront pobiera zasoby statyczne z Bucket S3 i dostarcza je do przeglądarki użytkownika
3. UI (React) komunikuje się z API poprzez API CloudFront i API Gateway
4. API Gateway kieruje żądania do odpowiednich funkcji Lambda w zależności od typu operacji
5. Funkcje Lambda przetwarzają żądania, komunikując się z dedykowanymi bazami danych:
   - Auth Lambda z Account Database
   - Showroom and Service Lambda z Showroom and Service Database
   - Shop Lambda z Shop Database oraz zewnętrznym systemem płatności tpay
6. Wyniki przetwarzania są zwracane przez API Gateway do warstwy frontendowej

=== Zalety przyjętego rozwiązania, rozdzielone bazy danych ograniczają ryzyko nieautoryzowanego dostępu
- *Optymalizacja kosztów* - model płatności za faktyczne użycie zasobów (pay-as-you-go)
- *Separacja odpowiedzialności* - każdy mikroserwis realizuje dedykowaną funkcjonalność biznesową z własną bazą danych
- *Izolacja danych* - niezależne bazy danych dla różnych obszarów funkcjonalnych zwiększają bezpieczeństwo i ułatwiają zarządzanie
- *Elastyczność integracji* - możliwość łatwej wymiany dostawcy płatności dzięki luźnemu powiązaniu z systemem zewnętrznymci od obciążenia
- *Wydajność* - użycie CloudFront w obu warstwach minimalizuje opóźnienia
- *Bezpieczeństwo* - API Gateway zapewnia centralne zarządzanie autoryzacją i dostępem
- *Optymalizacja kosztów* - model płatności za faktyczne użycie zasobów (pay-as-you-go)
- *Separacja odpowiedzialności* - każdy mikroserwis realizuje dedykowaną funkcjonalność biznesową
