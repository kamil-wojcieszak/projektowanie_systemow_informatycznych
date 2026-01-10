= Mechanizmy architektoniczne

Poniżej przedstawiono mechanizmy architektoniczne wspierające wyżej wymienione taktyki.

== 1A. Haszowanie haseł

W celu zapewnienia bezpieczeństwa przechowywanych haseł, system nie będzie przechowywał haseł w postaci jawnej. Hasła użytkowników będą haszowane przy użyciu bezpiecznego algorytmu kryptograficznego, takiego jak bcrypt lub Argon2.

== 2A. Szyfrowanie komunikacji z użyciem protokołu HTTPS

Komunikacja pomiędzy klientem a serwerem będzie realizowana wyłącznie z wykorzystaniem protokołu HTTPS, opartego na protokole TLS. Zapewnia to poufność, integralność oraz autentyczność przesyłanych danych, w szczególności danych uwierzytelniających oraz danych użytkowników.

== 3A. Projektowanie responsywne interfejsu użytkownika

Interfejs użytkownika systemu internetowego zostanie zaprojektowany zgodnie z zasadami Responsive Web Design (RWD), co umożliwi poprawne działanie aplikacji na urządzeniach mobilnych. Do realizacji responsywności wykorzystane zostaną frameworki CSS Flexbox, Grid oraz media queries, umożliwiające dynamiczne dopasowanie układu interfejsu do różnych rozdzielczości i orientacji ekranu.

== 4A. Pliki słowników językowych

Wszystkie etykiety stanu interfejsu użytkownika zostaną wyodrębnione do zewnętrznych plików słowników językowych, osobnych dla każdej wersji językowej. W zależności od wybranego języka interfejsu, aplikacja będzie dynamicznie wczytywać odpowiednie pliki słownikowe, co umożliwi łatwe rozszerzanie systemu o kolejne wersje językowe bez konieczności modyfikacji logiki aplikacji.
