= Analiza wybranych scenariuszy

W tej sekcji dokonano analizy czterech kluczowych scenariuszy jakościowych wybranych z drzewa użyteczności.

== Scenariusz 1: Utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)

*Atrybut:* Wydajność i skalowalność

*Bodziec:* Użytkownik wykonuje operację w systemie generującą zapytanie HTTP do API.

*Odpowiedź:* System zwraca odpowiedź w czasie ≤300ms dla 95% zapytań.

*Realizacja:*
- *AWS Lambda* - automatyczne skalowanie, niezależne serwisy (Auth, Shop, Showroom and Service)
- *API Gateway* - routing, throttling, zarządzanie priorytetami żądań
- *CloudFront CDN* - cachowanie, geograficzna dystrybucja, minimalizacja opóźnień
- *Rozdzielone bazy danych* - brak blokad między obszarami funkcjonalnymi, optymalizacja per baza

== Scenariusz 2: Wsparcie dla co najmniej 1000 równoczesnych użytkowników bez spadku wydajności

*Atrybut:* Wydajność i skalowalność

*Bodziec:* 1000+ użytkowników jednocześnie wykonuje operacje (przeglądanie, zakupy, rezerwacje).

*Odpowiedź:* System obsługuje wszystkich użytkowników utrzymując czas odpowiedzi \<300ms.

*Realizacja:*
- *Automatyczne skalowanie Lambda* - tworzenie nowych instancji, niezależne skalowanie mikroserwisów
- *API Gateway* - throttling, limity per użytkownik, queue management
- *CloudFront* - serwowanie statycznych zasobów z cache, redukcja żądań do Lambda
- *Rozdzielone bazy* - dedykowany obszar per baza, niezależne skalowanie

== Scenariusz 3: Zapewnienie szyfrowania wszystkich haseł użytkowników

*Atrybut:* Bezpieczeństwo

*Bodziec:* Rejestracja, zmiana hasła, logowanie, potencjalny wyciek bazy danych.

*Odpowiedź:* Hasła zahaszowane (bcrypt/Argon2), brak możliwości odzyskania w postaci jawnej.

*Realizacja:*
- *Auth Lambda* - implementacja bcrypt/Argon2, haszowanie przed zapisem
- *Mechanizm salt* - unikalny salt per hasło, ochrona przed rainbow table
- *Work factor/memory cost* - regulowana złożoność, odporność na brute force
- *Izolacja Account Database* - dedykowana baza, ograniczony dostęp tylko dla Auth Lambda

== Scenariusz 4: Zapewnienie szyfrowania całej komunikacji między klientem a serwerem

*Atrybut:* Bezpieczeństwo

*Bodziec:* Przesyłanie danych wrażliwych (logowanie, płatności, dane osobowe), potencjalny atak MITM.

*Odpowiedź:* Komunikacja przez HTTPS/TLS, szyfrowanie danych, autentyczność serwera, integralność danych.

*Realizacja:*
- *CloudFront HTTPS* - terminacja HTTPS, AWS Certificate Manager, wymuszenie HTTPS
- *API Gateway HTTPS* - szyfrowanie end-to-end, konfiguracja minimalnej wersji TLS 1.2+
- *Szyfrowane połączenia DB* - komunikacja Lambda-DB szyfrowana, AWS VPC, encryption at rest
- *Integracja tpay* - HTTPS, weryfikacja certyfikatu SSL/TLS, mechanizmy autoryzacji
