= Mechanizmy architektoniczne

Poniżej przedstawiono mechanizmy architektoniczne wspierające wyżej wymienione taktyki.

== Haszowanie haseł 

*Kontekst:*
System przechowuje dane uwierzytelniające użytkowników, które należą do danych wrażliwych i muszą być odpowiednio zabezpieczone przed nieautoryzowanym dostępem, w szczególności w przypadku wycieku bazy danych.

*Decyzja:*
Zastosowano mechanizm haszowania haseł użytkowników przy użyciu bezpiecznych algorytmów kryptograficznych, takich jak bcrypt lub Argon2. Hasła nie są przechowywane w postaci jawnej.

*Uzasadnienie:*
Algorytmy bcrypt i Argon2 są odporne na ataki brute-force dzięki wykorzystaniu mechanizmów solenia oraz regulowanej złożoności obliczeniowej. Ich zastosowanie znacząco zwiększa poziom bezpieczeństwa systemu w porównaniu do prostych funkcji skrótu (np. SHA-256).

*Konsekwencje:*
Zwiększenie bezpieczeństwa danych użytkowników kosztem niewielkiego wzrostu czasu potrzebnego na proces uwierzytelniania, co jest akceptowalne z punktu widzenia wymagań niefunkcjonalnych systemu.

== Szyfrowanie komunikacji z użyciem protokołu HTTPS

*Kontekst:*
System internetowy umożliwia przesyłanie danych użytkowników pomiędzy klientem a serwerem, w tym danych logowania oraz innych informacji wrażliwych.

*Decyzja:*
Zdecydowano się na realizację całej komunikacji sieciowej z wykorzystaniem protokołu HTTPS, opartego na protokole TLS.

*Uzasadnienie:*
HTTPS zapewnia poufność, integralność oraz autentyczność przesyłanych danych.

*Konsekwencje:*
Konieczność konfiguracji certyfikatów TLS oraz niewielki narzut wydajnościowy, który jest pomijalny w stosunku do uzyskanych korzyści bezpieczeństwa.

== Projektowanie responsywne interfejsu użytkownika

*Kontekst:*
System ma być dostępny dla użytkowników korzystających z różnych urządzeń, w tym komputerów stacjonarnych, tabletów oraz smartfonów o zróżnicowanych rozdzielczościach ekranów.

*Decyzja:*
Interfejs użytkownika został zaprojektowany zgodnie z zasadami Responsive Web Design (RWD), z wykorzystaniem technologii CSS Flexbox, CSS Grid oraz media queries.

*Uzasadnienie:*
Zastosowanie RWD umożliwia utrzymanie jednej wersji interfejsu, która automatycznie dostosowuje się do rozmiaru ekranu. Ogranicza to koszty utrzymania aplikacji oraz poprawia użyteczność systemu na urządzeniach mobilnych.

*Konsekwencje:*
Większa złożoność arkuszy stylów, jednak poprawa dostępności i komfortu użytkowania systemu na różnych platformach.

== Pliki słowników językowych

*Kontekst:*
System przewiduje obsługę dwóch wersji językowych interfejsu użytkownika.

*Decyzja:*
Zastosowano zewnętrzne pliki słowników językowych, osobne dla każdej wersji językowej, zawierające wszystkie etykiety i komunikaty interfejsu użytkownika.

*Uzasadnienie:*
Oddzielenie warstwy językowej od logiki aplikacji umożliwia łatwe dodawanie nowych wersji językowych bez ingerencji w kod źródłowy systemu. Rozwiązanie to zwiększa elastyczność oraz ułatwia utrzymanie aplikacji.

*Konsekwencje:*
Konieczność zarządzania dodatkowymi plikami konfiguracyjnymi, jednak znaczne uproszczenie procesu internacjonalizacji systemu.