= Widoki architektoniczne

== Widok kontekstowy

#figure(
  image("images/DiagramKontekstowy.png"),
  caption: [Diagram kontekstowy systemu],
)

== Scenariusze interakcji

Do realizacji wybrano zakup części i samochodów oraz umawianie wizyt w salonie i serwisie realizowane przez system do zarządzania działalnością salonu samochodowego. Interakcje składają się z żądań HTTP wysyłanych przez Klienta do systemu.


== Interfejsy integracyjne - poziom logiczny

=== Interfejs 1: System do zarządzania działalnością salonu samochodowego - Zewnętrzny serwis płatności (poza zakresem wymagań do implementacji)

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [Opis],
    table.cell(
      colspan: 2,
    )[Zewnętrzna usługa obsługi płatności oraz stanu konta użytkownika. Na tę usługę kierowana jest obsługa płatności w systemie],
    [Status], table.cell(colspan: 2)[Planowany],
    [], [Aplikacja źródłowa], [Aplikacja docelowa],
    [Nazwa aplikacji], [Sklep salonu], [Zewnętrzna bramka płatności np. PayU, Przelewy24, Tpay],
    [Technika integracji], [HTTPS], [HTTPS],
    [Mechanizm autentykacji], [nagłówek HTTP], [nagłówek HTTP],
    [Kontrakt danych],
    table.cell(
      colspan: 2,
    )[Identyfikator użytkownika, identyfikator zamówienia, kwota i waluta płatności, identyfikator płatności, identyfikator transakcji, informacje o błędach, stan konta użytkownika],
    [Czy interfejs manipuluje na danych wrażliwych (RODO)?],
    table.cell(colspan: 2)[Nie, identyfikator nie jest objęty RODO.],
    [Strona inicjująca], table.cell(colspan: 2)[Sklep salonu],
    [Model komunikacji], table.cell(colspan: 2)[Synchronicznie na żądanie użytkownika],
    [Wydajność], table.cell(colspan: 2)[Zależne od liczby użytkowników systemu, szacowane około 1000 / godz.],
    [Wolumetria],
    table.cell(
      colspan: 2,
    )[Szacowana ilość wywołań w jednostce czasu znacząco dłuższej niż w określeniu wydajności. Potrzebne do szacowania np. przestrzeni dyskowej niezbędnej do obsługi interfejsu.],
    [Wymagana dostępność], table.cell(colspan: 2)[99,9%],
  ),
  caption: [Interfejs integracyjny - System z zewnętrzną bramką płatności],
)

=== Interfejs 2: Klient - System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [Opis], table.cell(colspan: 2)[Wewnętrzna usługa obsługi zakupu części i samochodów przez użytkownika],
    [Status], table.cell(colspan: 2)[Planowany],
    [], [Aplikacja źródłowa], [Aplikacja docelowa],
    [Nazwa aplikacji], [Sklep salonu], [Sklep salonu],
    [Technika integracji], [HTTPS], [HTTPS],
    [Mechanizm autentykacji], [nagłówek HTTP], [nagłówek HTTP],
    [Kontrakt danych],
    table.cell(
      colspan: 2,
    )[Identyfikator użytkownika, identyfikator zamówienia, kwota płatności, identyfikator płatności, identyfikator transakcji, informacje o błędach],
    [Czy interfejs manipuluje na danych wrażliwych (RODO)?],
    table.cell(colspan: 2)[Nie, identyfikator nie jest objęty RODO.],
    [Strona inicjująca], table.cell(colspan: 2)[Klient],
    [Model komunikacji], table.cell(colspan: 2)[Synchronicznie na żądanie użytkownika],
    [Wydajność], table.cell(colspan: 2)[Zależne od liczby użytkowników systemu, szacowane około 1000 / godz.],
    [Wolumetria],
    table.cell(colspan: 2)[Ok 100 / godzinę],
    [Wymagana dostępność], table.cell(colspan: 2)[99,9%],
  ),
  caption: [Interfejs integracyjny - Klient ze Sklepem salonu (zakup części i samochodów)],
)

=== Interfejs 3: Klient - System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [Opis], table.cell(colspan: 2)[Wewnętrzna usługa obsługi umawiania wizyt w salonie przez użytkownika],
    [Status], table.cell(colspan: 2)[Planowany],
    [], [Aplikacja źródłowa], [Aplikacja docelowa],
    [Nazwa aplikacji], [Strona salonu], [Strona salonu],
    [Technika integracji], [HTTPS], [HTTPS],
    [Mechanizm autentykacji], [nagłówek HTTP], [nagłówek HTTP],
    [Kontrakt danych],
    table.cell(
      colspan: 2,
    )[Identyfikator użytkownika, identyfikator wizyty, identyfikator samochodu, identyfikator pracownika, rodzaj wizyty, data wizyty, status wizyty],
    [Czy interfejs manipuluje na danych wrażliwych (RODO)?],
    table.cell(colspan: 2)[Nie, identyfikator nie jest objęty RODO.],
    [Strona inicjująca], table.cell(colspan: 2)[Klient],
    [Model komunikacji], table.cell(colspan: 2)[Synchronicznie na żądanie użytkownika],
    [Wydajność], table.cell(colspan: 2)[Zależne od liczby użytkowników systemu, szacowane około 1000 / godz.],
    [Wolumetria],
    table.cell(colspan: 2)[Ok 15 / godzine],
    [Wymagana dostępność], table.cell(colspan: 2)[70%],
  ),
  caption: [Interfejs integracyjny - Klient ze Stroną salonu (wizyty w salonie)],
)

=== Interfejs 4: Klient - System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [Opis], table.cell(colspan: 2)[Wewnętrzna usługa obsługi umawiania wizyt w serwisie przez użytkownika],
    [Status], table.cell(colspan: 2)[Planowany],
    [], [Aplikacja źródłowa], [Aplikacja docelowa],
    [Nazwa aplikacji], [Strona serwisu], [Strona serwisu],
    [Technika integracji], [HTTPS], [HTTPS],
    [Mechanizm autentykacji], [nagłówek HTTP], [nagłówek HTTP],
    [Kontrakt danych],
    table.cell(
      colspan: 2,
    )[Identyfikator użytkownika, identyfikator wizyty, identyfikator pracownika, rodzaj wizyty, data wizyty, status wizyty, cena usługi, nazwa usługi, opis usługi, marka samochodu, model samochodu, rocznik samochodu, opis problemu],
    [Czy interfejs manipuluje na danych wrażliwych (RODO)?],
    table.cell(colspan: 2)[Nie, identyfikator nie jest objęty RODO.],
    [Strona inicjująca], table.cell(colspan: 2)[Sklep salonu],
    [Model komunikacji], table.cell(colspan: 2)[Synchronicznie na żądanie użytkownika],
    [Wydajność], table.cell(colspan: 2)[Zależne od liczby użytkowników systemu, szacowane około 1000 / godz.],
    [Wolumetria],
    table.cell(colspan: 2)[Ok 3 / godzinę],
    [Wymagana dostępność], table.cell(colspan: 2)[70%],
  ),
  caption: [Interfejs integracyjny - Klient ze Stroną serwisu (wizyty w serwisie)],
)
