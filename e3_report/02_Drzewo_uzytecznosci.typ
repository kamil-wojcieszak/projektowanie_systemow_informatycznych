= Drzewo użyteczności

=== Interfejs 2: Klient - System do zarządzania działalnością salonu samochodowego

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
  stroke: 1pt,
  inset: 6pt,
  [*Atrybut jakości*], [*Udoskonalenie atrybutu*], [*Scenariusze*],
[Wydajność i skalowalność], [Czas odpowiedzi na zapytanie
----------------------------
Liczba użytkowników], [- utrzymanie czasu odpowiedzi API na poziomie średnio 300ms (95 percentyl)
- wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności],
[Bezpieczeństwo], [Przechowywanie danych
----------------------------
Komunikacja], [- zapewnienie szyfrowania wszystkich haseł użytkowników, 
- zapewnienie szyfrowania całej komunikacji między klientem a serwerem],
[Dostępność], [Czas dostępności], [- zapewnienie drugiej klasy dostępności (dostępność usługi przez co najmniej 99% czasu)],
  [RODO], [Pozyskiwanie danych,
  ----------,
  Pozbywanie się danych], [- mechanizm umożliwiający pobranie danych osobowych (JSON/CSV),
  - możliwość całkowitego usunięcia konta wraz z danymi w ciągu maksymalnie 30 dni],
  ),
  caption: [],
)