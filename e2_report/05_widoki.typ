= Widoki architektoniczne

== Widok kontekstowy

=== Diagram kontekstowy

XXX zdjecie diagramu kontekstowego XXX
// #figure(
//   image("images/diagram_kontekstowy.png"),
//   caption: [Diagram kontekstowy systemu]
// )

=== Scenariusze interakcji

Do realizacji przeznaczona została obsługa płatności realizowana przez zewnętrzny serwis płatności. Interakcja ogranicza się do pojedynczego żądania HTTP wysyłanego przez system do serwisu płatności, w którym przekazywane są dane transakcji. Odpowiedź zawiera informację o statusie płatności, na podstawie której aktualizowana jest dane zamówienia w systemie.

=== Interfejsy integracyjne - poziom logiczny

==== Interfejs 1: System do zarządzania działalnością salonu samochodowego - Zewnętrzny serwis płatności (poza zakresem wymagań do implementacji)

#table(
  columns: (1fr, 1fr, 1fr),
  [Opis], table.cell(colspan: 2)[Zewnętrzna usługa obsługi płatności oraz stanu konta użytkownika. Na tę usługę kierowana jest obsługa płatności w systemie],
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
  table.cell(colspan: 2)[Szacowana ilość wywołań w jednostce czasu znacząco dłuższej niż w określeniu wydajności. Potrzebne do szacowania np. przestrzeni dyskowej niezbędnej do obsługi interfejsu.],
  [Wymagana dostępność], table.cell(colspan: 2)[99,9%],
)
