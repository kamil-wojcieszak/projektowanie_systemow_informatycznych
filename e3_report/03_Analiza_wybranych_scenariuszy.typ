= Analiza wybranych scenariuszy

W tej sekcji dokonano analizy czterech kluczowych scenariuszy jakościowych wybranych z drzewa użyteczności. Dla każdego scenariusza określono sposób jego realizacji w obecnej architekturze oraz zidentyfikowano punkty wrażliwości i kompromisy.

== Scenariusz 1: Utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)

=== Atrybut jakości
Wydajność i skalowalność

=== Kontekst
System zarządzania działalnością salonu samochodowego obsługuje równoczesne zapytania od wielu użytkowników wykonujących różne operacje (przeglądanie katalogu, składanie zamówień, rezerwacje wizyt). Użytkownik oczekuje płynnego działania aplikacji bez zauważalnych opóźnień.

=== Bodziec
Użytkownik wykonuje operację w systemie (np. wyszukiwanie części w sklepie, rezerwacja wizyty w serwisie), która generuje zapytanie HTTP do API.

=== Odpowiedź
System przetwarza żądanie i zwraca odpowiedź w czasie nie przekraczającym 300ms dla 95% wszystkich zapytań.

=== Realizacja w architekturze

*Decyzje architektoniczne wspierające scenariusz:*

1. *Architektura mikroserwisowa na AWS Lambda*
   - Funkcje Lambda umożliwiają automatyczne skalowanie w odpowiedzi na wzrost liczby żądań
   - Niezależne serwisy (Auth, Shop, Showroom and Service) mogą być skalowane osobno w zależności od obciążenia

2. *API Gateway jako punkt wejściowy*
   - Zarządza routingiem żądań do odpowiednich funkcji Lambda
   - Umożliwia implementację throttlingu i zarządzania priorytetami żądań

3. *CloudFront CDN dla API i Frontend*
   - Cachowanie odpowiedzi API redukuje obciążenie backendu dla częstych zapytań
   - Geograficzna dystrybucja węzłów CDN minimalizuje opóźnienia sieciowe
   - Statyczne zasoby frontend dostępne z najbliższego punktu dystrybucji

4. *Rozdzielone bazy danych*
   - Account Database, Shop Database oraz Showroom and Service Database działają niezależnie
   - Brak wzajemnych blokad między różnymi obszarami funkcjonalnymi
   - Możliwość optymalizacji każdej bazy pod kątem specyficznych zapytań

=== Punkty wrażliwości i kompromisy

*Punkty wrażliwości:*
- Cold start funkcji Lambda może powodować opóźnienia pierwszego żądania
- Zapytania wymagające złączeń między różnymi bazami danych mogą przekroczyć zakładany czas odpowiedzi
- Zbyt agresywne cachowanie w CloudFront może prowadzić do zwracania nieaktualnych danych

*Kompromisy:*
- Zachowanie minimalnej liczby warm instancji Lambda zwiększa koszty operacyjne, ale redukuje opóźnienia
- Krótszy TTL cache zwiększa świeżość danych, ale obciąża backend większą liczbą żądań
- Denormalizacja danych w bazach poprawia wydajność odczytu, ale komplikuje operacje zapisu

== Scenariusz 2: Wsparcie dla co najmniej 1000 równoczesnych użytkowników bez spadku wydajności

=== Atrybut jakości
Wydajność i skalowalność

=== Kontekst
W godzinach szczytu (np. podczas promocji, premier nowych modeli) system obsługuje znaczną liczbę równoczesnych użytkowników wykonujących różnorodne operacje.

=== Bodziec
1000 lub więcej użytkowników jednocześnie korzysta z systemu, wykonując operacje takie jak:
- Przeglądanie oferty samochodów i części
- Dodawanie produktów do koszyka
- Składanie zamówień
- Rezerwacja wizyt w salonie i serwisie

=== Odpowiedź
System obsługuje wszystkich użytkowników bez degradacji wydajności, utrzymując średni czas odpowiedzi API poniżej 300ms.

=== Realizacja w architekturze

*Decyzje architektoniczne wspierające scenariusz:*

1. *Automatyczne skalowanie funkcji Lambda*
   - AWS Lambda automatycznie tworzy nowe instancje funkcji w odpowiedzi na wzrost liczby żądań
   - Każdy mikroserwis (Auth, Shop, Showroom and Service) skaluje się niezależnie
   - Brak konieczności ręcznej konfiguracji klastrów serwerów

2. *API Gateway z zarządzaniem ruchem*
   - Throttling na poziomie API Gateway chroni backend przed przeciążeniem
   - Możliwość ustawienia limitów żądań per użytkownik/API key
   - Queue management dla kolejkowania żądań w okresach szczytowego obciążenia

3. *CloudFront jako warstwa cachowania*
   - Statyczne zasoby (katalog produktów, obrazy, cenniki) serwowane z cache
   - Redukcja liczby żądań docierających do funkcji Lambda
   - Geograficzna dystrybucja obciążenia

4. *Rozdzielone bazy danych*
   - Każda baza (Account, Shop, Showroom and Service) obsługuje dedykowany obszar funkcjonalny
   - Brak współdzielonych zasobów między różnymi typami operacji
   - Możliwość niezależnego skalowania i optymalizacji każdej bazy

=== Punkty wrażliwości i kompromisy

*Punkty wrażliwości:*
- Limity AWS Lambda (domyślnie 1000 równoczesnych wykonań na region) mogą wymagać zwiększenia
- Bazy danych mogą stać się wąskim gardłem przy bardzo dużej liczbie operacji zapisu
- Koszty rosną proporcjonalnie do liczby równoczesnych użytkowników (model pay-per-use)

*Kompromisy:*
- Agresywne cachowanie zmniejsza obciążenie, ale może prowadzić do nieaktualnych danych
- Connection pooling w bazach danych poprawia wydajność, ale zwiększa złożoność zarządzania
- Read replicas dla baz danych zwiększają przepustowość odczytu, ale wprowadzają opóźnienia replikacji

== Scenariusz 3: Zapewnienie szyfrowania wszystkich haseł użytkowników

=== Atrybut jakości
Bezpieczeństwo

=== Kontekst
System przechowuje dane uwierzytelniające użytkowników w Account Database. Hasła należą do danych szczególnie wrażliwych i wymagają najwyższego poziomu ochrony.

=== Bodziec
- Nowy użytkownik rejestruje się w systemie i tworzy hasło
- Użytkownik zmienia swoje hasło
- Użytkownik loguje się do systemu
- Potencjalny scenariusz naruszenia: nieautoryzowany dostęp do bazy danych

=== Odpowiedź
- Hasła są przechowywane w formie zahaszowanej przy użyciu algorytmu bcrypt lub Argon2
- Weryfikacja hasła podczas logowania nie wymaga jego odszyfrowania
- W przypadku wycieku bazy danych, atakujący nie może odzyskać haseł w postaci jawnej

=== Realizacja w architekturze

*Decyzje architektoniczne wspierające scenariusz:*

1. *Auth Lambda z implementacją haszowania*
   - Moduł Auth Lambda odpowiedzialny za przetwarzanie operacji uwierzytelniania
   - Implementacja bezpiecznych algorytmów haszowania (bcrypt/Argon2)
   - Hasła są haszowane przed zapisem do Account Database

2. *Mechanizm salt dla haseł*
   - Każde hasło otrzymuje unikalny salt
   - Ochrona przed atakami rainbow table
   - Salt przechowywany wraz z hashem w bazie danych

3. *Regulowana złożoność obliczeniowa*
   - Parametry work factor (bcrypt) lub memory cost (Argon2) konfigurowane dla zwiększenia odporności na brute force
   - Możliwość dostosowania poziomu zabezpieczeń w zależności od wymagań

4. *Izolacja Account Database*
   - Dedykowana baza danych tylko dla danych uwierzytelniających
   - Ograniczony dostęp tylko dla Auth Lambda
   - Dodatkowa warstwa zabezpieczeń przez separację od innych danych

=== Punkty wrażliwości i kompromisy

*Punkty wrażliwości:*
- Implementacja algorytmu haszowania w Auth Lambda - błąd w implementacji może osłabić zabezpieczenia
- Parametry konfiguracyjne (work factor, memory cost) - zbyt niskie wartości osłabiają ochronę
- Dostęp do Account Database - nieodpowiednia konfiguracja uprawnień może umożliwić nieautoryzowany dostęp

*Kompromisy:*
- Wyższa złożoność obliczeniowa zwiększa bezpieczeństwo, ale wydłuża czas logowania i rejestracji
- Silniejsze parametry haszowania zwiększają obciążenie CPU funkcji Lambda, co przekłada się na wyższe koszty
- Dodatkowa walidacja siły hasła (wymóg długości, znaków specjalnych) poprawia bezpieczeństwo, ale może frustrować użytkowników

== Scenariusz 4: Zapewnienie szyfrowania całej komunikacji między klientem a serwerem

=== Atrybut jakości
Bezpieczeństwo

=== Kontekst
System obsługuje przesyłanie danych wrażliwych między przeglądarką użytkownika a serwerem, w tym danych logowania, informacji osobowych, danych płatności oraz szczegółów rezerwacji.

=== Bodziec
- Użytkownik loguje się do systemu, przesyłając dane uwierzytelniające
- Użytkownik dokonuje zakupu w sklepie internetowym, podając dane płatnicze
- Użytkownik rezerwuje wizytę w salonie lub serwisie, przesyłając dane osobowe
- Potencjalny atak: próba przechwycenia komunikacji (man-in-the-middle)

=== Odpowiedź
- Cała komunikacja między klientem a serwerem odbywa się przez HTTPS/TLS
- Dane w trakcie transmisji są zaszyfrowane i chronione przed przechwyceniem
- Zapewniona jest autentyczność serwera (weryfikacja certyfikatu)
- Zachowana jest integralność danych (wykrycie modyfikacji)

=== Realizacja w architekturze

*Decyzje architektoniczne wspierające scenariusz:*

1. *CloudFront z obsługą HTTPS*
   - Frontend CloudFront terminuje połączenia HTTPS
   - Automatyczne zarządzanie certyfikatami TLS przez AWS Certificate Manager
   - Wymuszenie HTTPS dla wszystkich żądań (przekierowanie HTTP → HTTPS)

2. *API Gateway z HTTPS*
   - API CloudFront i API Gateway wymagają HTTPS dla wszystkich żądań API
   - Szyfrowanie end-to-end od przeglądarki użytkownika do API Gateway
   - Możliwość konfiguracji minimalnej wersji TLS (TLS 1.2+)

3. *Route 53 z obsługą HTTPS*
   - Routing DNS wspiera protokół HTTPS
   - Możliwość konfiguracji DNSSEC dla dodatkowej warstwy bezpieczeństwa

4. *Szyfrowane połączenia do baz danych*
   - Komunikacja między funkcjami Lambda a bazami danych również szyfrowana
   - Wykorzystanie AWS VPC dla izolacji sieci
   - Encryption at rest dla danych w bazach

5. *Bezpieczna integracja z tpay*
   - Komunikacja z zewnętrznym dostawcą płatności (tpay) przez HTTPS
   - Weryfikacja certyfikatu SSL/TLS dostawcy
   - Dodatkowe mechanizmy autoryzacji (API keys, tokeny)
