= Drzewo użyteczności



#figure(
  table(
    columns: (2fr, 3fr, 5fr),
    
    stroke: 1pt,
    inset: 6pt,
    [*Atrybut jakości*], [*Udoskonalenie atrybutu*], [*Scenariusze*],
    
    table.cell(rowspan: 2)[Wydajność i skalowalność],
    [Czas odpowiedzi na zapytanie],
    [Utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl) (L, M)],

    [Liczba użytkowników],
    [Wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności (H, M)],

    table.cell(rowspan: 2)[Bezpieczeństwo],
    [Ochrona danych],
    [Wartości haseł wszystkich użytkowników nie mogą być możliwe do przeczytania (H, M)],

    [Ochrona komunikacji],
    [Brak możliwości przechwycenia przez użytkownika postronnego komunikacji między klientem a serwerem (H, M)],

    [Dostępność],
    [Czas dostępności],
    [Zapewnienie dostępności do aplikacji przez co najmniej 99% czasu (H, H)],

    table.cell(rowspan: 2)[RODO],
    [Pozyskiwanie danych],
    [Mechanizm umożliwiający pobranie danych osobowych (JSON/CSV) (H, L)],

    [Pozbywanie się danych],
    [Możliwość całkowitego usunięcia konta wraz z danymi w ciągu maksymalnie 30 dni (M, L)],
  ),
  caption: [Drzewo użyteczności - atrybuty jakości i scenariusze; Struktura priorytetów: "(korzyść biznesowa wg klienta, trudność osiągnięcia celów scenariusza)"],
)
