= Widok rozmieszczenia

== Diagram rozmieszczenia

#figure(
  image("images/architektua-aws.jpg", width: 100%),
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

System wykorzystuje pięć funkcji Lambda, które realizują różne funkcjonalności biznesowe:

- *Showroom Lambda* - zarządzanie ekspozycją pojazdów i prezentacją oferty
- *Shop Lambda* - obsługa procesów związanych ze sprzedażą i transakcjami
- *Service Lambda* - zarządzanie usługami serwisowymi i naprawami
- *Auth Lambda* - obsługa uwierzytelniania i autoryzacji użytkowników

=== Komunikacja między komponentami

System charakteryzuje się następującym przepływem danych:

1. Użytkownik łączy się przez Route 53, który kieruje ruch do Frontend CloudFront
2. Frontend CloudFront pobiera zasoby statyczne z Bucket S3 i dostarcza je do przeglądarki użytkownika
3. UI (React) komunikuje się z API poprzez API CloudFront i API Gateway
4. API Gateway kieruje żądania do odpowiednich funkcji Lambda w zależności od typu operacji
5. Funkcje Lambda przetwarzają żądania i zwracają odpowiedzi przez API Gateway

=== Zalety przyjętego rozwiązania

- *Skalowalność* - architektura serverless (Lambda) pozwala na automatyczne skalowanie w zależności od obciążenia
- *Wydajność* - użycie CloudFront w obu warstwach minimalizuje opóźnienia
- *Bezpieczeństwo* - API Gateway zapewnia centralne zarządzanie autoryzacją i dostępem
- *Optymalizacja kosztów* - model płatności za faktyczne użycie zasobów (pay-as-you-go)
- *Separacja odpowiedzialności* - każdy mikroserwis realizuje dedykowaną funkcjonalność biznesową
