= Widok informacyjny

== Model informacyjny

== Projekt bazy danych

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Ogólne informacje nt. bazy danych (osobna tabela dla każdej bazy)*],
  [SID/Service Name], [SALON_DB],
  [Nazwa serwera], [DeEs.myqnapcloud.com],
  [Port], [1521],
  [Type], [Oracle Database 19c],
  [Kodowanie znaków], [AL32UTF8],
  [Opis], [Relacyjna baza danych systemu salonu i serwisu samochodowego. Baza przechowuje dane produktów, koszyków, rezerwacji wizyt, usług serwisowych.],
  [Technologie], [Sequences, Constraints]
)

=== Backup

#table(
  columns: (1fr,),
  [Backup],
  [Dane przechowywane w systemie sklepu, salonu i serwisu samochodowego obejmują m.in. rezerwacje wizyt, informacje o produktach oraz zamówienia. Dane te mają istotne znaczenie dla poprawnego funkcjonowania systemu, jednak nie wymagają natychmiastowego odtworzenia w przypadku pojedynczych zmian.

  Pełne kopie zapasowe bazy danych wykonywane są raz w tygodniu, natomiast kopie przyrostowe wykonywane są codziennie w godzinach nocnych, w celu ograniczenia wpływu na dostępność systemu.
  Przechowywane są trzy ostatnie pełne kopie zapasowe, co umożliwia odtworzenie danych z wybranego punktu w czasie w przypadku awarii lub błędu logicznego.]
)
// (W tym wolumen danych, zakres backupu, częstotliwość, tryb, okres protekcji)

==== Schemat 

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Informacje o schemacie*],
  [Nazwa], [SALON_SCHEMA],
  [Początkowa pojemność], [~25 MB + metadane],
  [Przyrost pojemności (rok)], [~50 MB + metadane],
  [Niezbędne prawa], [CREATE TABLE, CREATE SEQUENCE, INSERT, UPDATE, DELETE, SELECT]
)

Pojemność początkowa bazy została oszacowana poprzez zsumowanie przewidywanych rozmiarów rekordów dla każdej tabeli (np. produkty, usługi) na podstawie liczby kolumn i typów danych, powiększonych o przestrzeń na metadane bazy. Przyrost danych roczny oszacowano na podstawie przewidywanej liczby nowych użytkowników, rezerwacji i transakcji oraz średniego rozmiaru rekordu w każdej tabeli.
