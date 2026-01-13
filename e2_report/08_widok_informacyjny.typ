= Widok informacyjny

== Model informacyjny

#figure(
 image("images/account_model_v1.JPG"),
 // caption: []
)

#figure(
 image("images/internet_shop_model.JPG"),
 // caption: []
)

#figure(
 image("images/car_showroom_service_model.JPG"),
 // caption: []
)

== Projekt bazy danych

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Ogólne informacje nt. bazy danych (osobna tabela dla każdej bazy)*],
  [SID/Service Name], [SKLEP_DB],
  [Nazwa serwera], [DeEs.myqnapcloud.com],
  [Port], [1521],
  [Type], [Oracle Database 19c],
  [Kodowanie znaków], [AL32UTF8],
  [Opis], [Relacyjna baza danych sklepu internetowego. Baza przechowuje dane produktów, koszyków, zamówienia.],
  [Technologie], [Sequences, Constraints]
)

Backup

#table(
  columns: (1fr,),
  [Backup],
  [Dane przechowywane w systemie sklepu obejmują konta użytkowników, katalog produktów i kategorii, koszyki zakupowe, zamówienia oraz opinie o produktach. Dane te mają kluczowe znaczenie dla poprawnego funkcjonowania systemu, w szczególności w zakresie realizacji zakupów i rozliczeń.

  Pełne kopie zapasowe bazy danych wykonywane są raz w tygodniu, natomiast kopie przyrostowe wykonywane są codziennie w godzinach nocnych w celu ograniczenia wpływu na dostępność systemu.
  Przechowywane są trzy ostatnie pełne kopie zapasowe, co umożliwia odtworzenie danych po awarii sprzętowej lub w przypadku błędów logicznych (np. niezamierzonego usunięcia danych).]
)
// (W tym wolumen danych, zakres backupu, częstotliwość, tryb, okres protekcji)

Schemat 

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Informacje o schemacie*],
  [Nazwa], [SKLEP_SCHEMA],
  [Początkowa pojemność], [\u{007E}25 MB + metadane],
  [Przyrost pojemności (rok)], [\u{007E}50 MB + metadane],
  [Niezbędne prawa], [CREATE TABLE, CREATE SEQUENCE, INSERT, UPDATE, DELETE, SELECT]
)

Pojemność początkowa bazy została oszacowana poprzez zsumowanie przewidywanych rozmiarów rekordów dla każdej tabeli
(users, products, categories, carts, orders, reviews) na podstawie liczby kolumn oraz typów danych (number, varchar, date, text),
a następnie powiększona o przestrzeń na metadane bazy (definicje tabel, klucze główne i obce, constraints, sekwencje).

Przyrost danych roczny oszacowano na podstawie przewidywanej liczby nowych użytkowników, zamówień oraz opinii,
a także średniego rozmiaru pojedynczego rekordu w tabelach orders, order_items oraz product_reviews,
które generują największy wolumen danych w czasie.

#figure(
 image("images/sklep.png"),
 // caption: []
)

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Ogólne informacje nt. bazy danych (osobna tabela dla każdej bazy)*],
  [SID/Service Name], [SALON_DB],
  [Nazwa serwera], [DeEs.myqnapcloud.com],
  [Port], [1521],
  [Type], [Oracle Database 19c],
  [Kodowanie znaków], [AL32UTF8],
  [Opis], [Relacyjna baza danych salonu samochodowego.],
  [Technologie], [Sequences, Constraints]
)

Backup

#table(
  columns: (1fr,),
  [Backup],
  [Dane przechowywane w bazie salonu samochodowego obejmują ofertę pojazdów oraz rezerwacje wizyt w salonie (jazdy próbne, konsultacje, zakup). Dane te są istotne dla obsługi klientów i planowania pracy salonu, jednak w przypadku pojedynczych zmian nie wymagają natychmiastowego odtworzenia.

  Pełne kopie zapasowe bazy danych wykonywane są raz w tygodniu, natomiast kopie przyrostowe wykonywane są codziennie w godzinach nocnych w celu minimalizacji wpływu na dostępność systemu.
  Przechowywane są trzy ostatnie pełne kopie zapasowe, co umożliwia odtworzenie danych do wybranego punktu w czasie w przypadku awarii lub błędów operacyjnych.]
)
// (W tym wolumen danych, zakres backupu, częstotliwość, tryb, okres protekcji)

Schemat

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Informacje o schemacie*],
  [Nazwa], [SALON_SCHEMA],
  [Początkowa pojemność], [≈10 MB + metadane],
  [Przyrost pojemności (rok)], [≈20 MB + metadane],
  [Niezbędne prawa], [CREATE TABLE, CREATE SEQUENCE, INSERT, UPDATE, DELETE, SELECT]
)

Początkowa pojemność bazy została oszacowana na podstawie przewidywanej liczby rekordów w tabelach users, vehicles oraz salon_visits
oraz średniego rozmiaru pojedynczego rekordu (dane opisowe pojazdów oraz terminy wizyt), powiększonych o przestrzeń na metadane bazy
(definicje tabel, klucze główne i obce, constraints oraz sekwencje).

Roczny przyrost danych wynika głównie z przyrostu liczby użytkowników oraz rezerwacji wizyt w salonie,
które są zapisywane w tabeli salon_visits. Tabele vehicles oraz users rosną wolniej,
co powoduje umiarkowany i przewidywalny wzrost całkowitego rozmiaru bazy.

#figure(
 image("images/salon.png"),
 // caption: []
)

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Ogólne informacje nt. bazy danych (osobna tabela dla każdej bazy)*],
  [SID/Service Name], [SERWIS_DB],
  [Nazwa serwera], [DeEs.myqnapcloud.com],
  [Port], [1521],
  [Type], [Oracle Database 19c],
  [Kodowanie znaków], [AL32UTF8],
  [Opis], [Relacyjna baza danych serwisu samochodowego.],
  [Technologie], [Sequences, Constraints]
)

Backup

#table(
  columns: (1fr,),
  [Backup],
  [Dane przechowywane w bazie serwisu samochodowego obejmują katalog usług serwisowych oraz rezerwacje wizyt serwisowych wraz z opisami usterek i danymi technicznymi pojazdów. Dane te są kluczowe dla realizacji usług serwisowych oraz rozliczeń z klientami.

  Pełne kopie zapasowe bazy danych wykonywane są raz w tygodniu, natomiast kopie przyrostowe wykonywane są codziennie w godzinach nocnych, aby zminimalizować wpływ na dostępność systemu.
  Przechowywane są trzy ostatnie pełne kopie zapasowe, co umożliwia odtworzenie danych do wybranego punktu w czasie w przypadku awarii lub błędu logicznego.]
)
// (W tym wolumen danych, zakres backupu, częstotliwość, tryb, okres protekcji)

Schemat

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Informacje o schemacie*],
  [Nazwa], [SERVICE_SCHEMA],
  [Początkowa pojemność], [≈15 MB + metadane],
  [Przyrost pojemności (rok)], [≈40 MB + metadane],
  [Niezbędne prawa], [CREATE TABLE, CREATE SEQUENCE, INSERT, UPDATE, DELETE, SELECT]
)

Początkowa pojemność bazy została oszacowana na podstawie przewidywanej liczby rekordów w tabelach users, services oraz service_visits.
Największy wpływ na rozmiar mają dane w tabeli service_visits, które zawierają opisy usterek oraz szczegóły techniczne pojazdów,
zajmujące relatywnie więcej miejsca niż dane słownikowe.

Roczny przyrost danych oszacowano głównie na podstawie przewidywanej liczby nowych wizyt serwisowych,
ponieważ każda wizyta generuje nowy rekord z opisem problemu oraz danymi pojazdu.
Tabela services jest względnie stała, natomiast tabela users rośnie umiarkowanie wraz z napływem nowych klientów.

#figure(
 image("images/serwis.png"),
 // caption: []
)