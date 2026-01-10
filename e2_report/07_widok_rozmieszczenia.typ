= Widok rozmieszczenia

== Diagram rozmieszczenia

== Opis węzłów

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Ogólne informacje*],
  [Nazwa], [Hostname],
  [Węzeł wirtualny?], [Tak/Nie],
  [Centrum danych?], [No/PDC/BDC],
  [OS], [System operacyjny wraz z wersją],
  [Opis], []
)

=== Konfiguracja sprzętowa

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Konfiguracja sprzętowa*],
  [Dostawca], [Nazwa sprzętu producenta],
  [Procesor], [Ilość i rodzaj procesorów],
  [RAM], [….],
  [HDD], [Wielkość i ilość dysków],
  [RAID i HDD Netto], [Rodzaj konfiguracji RAID i wielkość netto HDD.],
  [RAID?], [Brak/Do jakiej macierzy podłączony],
  [Net cards bonding], [Nie/Tak…]
)

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2)[*Konfiguracja oprogramowania*],
  [Użytkownicy i grupy użytkowników], [Lista użytkowników do założenia na OS'ie.],
  [Poziom pracy systemu, czy jest wymagane środowisko graficzne], [],
  [Dodatkowe pakiety z dystrybucji systemu], [],
  [Dodatkowe pakiety spoza dystrybucji systemu], []
)
