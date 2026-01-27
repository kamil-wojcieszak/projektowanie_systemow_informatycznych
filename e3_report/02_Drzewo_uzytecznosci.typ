= Drzewo użyteczności

=== Interfejs 2: Klient System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (2fr, 3fr, 5fr),
    
    stroke: 1pt,
    inset: 6pt,
    [*Atrybut jakości*], [*Udoskonalenie atrybutu*], [*Scenariusze*],
    
    table.cell(rowspan: 2)[Wydajność i skalowalność],
    [Czas odpowiedzi na zapytanie],
    [utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)],

    [Liczba użytkowników],
    [wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności],

    table.cell(rowspan: 2)[Bezpieczeństwo],
    [Przechowywanie danych],
    [zapewnienie szyfrowania wszystkich haseł użytkowników],

    [Komunikacja],
    [zapewnienie szyfrowania całej komunikacji między klientem a serwerem],

    [Dostępność],
    [Czas dostępności],
    [zapewnienie drugiej klasy dostępności (dostępność usługi przez co najmniej 99% czasu)],

    table.cell(rowspan: 2)[RODO],
    [Pozyskiwanie danych],
    [mechanizm umożliwiający pobranie danych osobowych (JSON/CSV)],

    [Pozbywanie się danych],
    [możliwość całkowitego usunięcia konta wraz z danymi w ciągu maksymalnie 30 dni],
  ),
  caption: [Drzewo użyteczności - atrybuty jakości i scenariusze],
)
