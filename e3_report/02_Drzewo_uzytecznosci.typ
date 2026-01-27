= Drzewo użyteczności

=== Interfejs 2: Klient - System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    [*Atrybut jakości*], [*Udoskonalenie atrybutu*], [*Scenariusze*],
    [Wydajność i skalowalność],
    [],
    [
      - utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)
      - wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności
    ],

    [Bezpieczeństwo],
    [],
    [
      - zapewnienie szyfrowania wszystkich haseł użytkowników,
      - zapewnienie szyfrowania całej komunikacji między klientem a serwerem
    ],

    [Dostępność], [], [- zapewnienie drugiej klasy dostępności (dostępność usługi przez co najmniej 99% czasu)],
    [RODO],
    [],
    [
      - mechanizm umożliwiający pobranie danych osobowych (JSON/CSV),
      - możliwość całkowitego usunięcia konta wraz z danymi w ciągu maksymalnie 30 dni
    ],
  ),
  caption: [],
)
