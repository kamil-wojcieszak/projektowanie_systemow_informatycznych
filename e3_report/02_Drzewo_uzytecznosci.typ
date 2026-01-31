= Drzewo użyteczności



#figure(
  table(
    columns: (2fr, 3fr, 5fr),
    
    stroke: 1pt,
    inset: 6pt,
    [*Atrybut jakości*], [*Udoskonalenie atrybutu*], [*Scenariusze*],
    
    table.cell(rowspan: 2)[Wydajność i skalowalność],
    [Czas odpowiedzi na zapytanie],
    [Utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)],

    [Liczba użytkowników],
    [Wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności],

    table.cell(rowspan: 2)[Bezpieczeństwo],
    [Ochrona danych],
    [Wartości haseł wszystkich użytkowników nie mogą być możliwe do przeczytania],

    [Ochrona komunikacji],
    [Brak możliwości przechwycenia przez użytkownika postronnego komunikacji między klientem a serwerem],

    table.cell(rowspan: 2)[Dostępność],
    [Czas dostępności],
    [Zapewnienie dostępności do aplikacji przez co najmniej 99% czasu],

    [skalowalność],
    [System musi obsłużyć wzmożony ruch użytkowników w okresach szczytowych (np. sesja egzaminacyjna)],

    table.cell(rowspan: 2)[RODO],
    [Pozyskiwanie danych],
    [Mechanizm umożliwiający pobranie danych osobowych (JSON/CSV)],

    [Pozbywanie się danych],
    [Możliwość całkowitego usunięcia konta wraz z danymi w ciągu maksymalnie 30 dni],
  ),
  caption: [Drzewo użyteczności - atrybuty jakości i scenariusze],
)
