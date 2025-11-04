#include "title_page.typ"

#set figure(supplement: [Zdjęcie])

= Specyfikacja i analiza wymaga
== Cel i zakres projektu

=== Cel projektu:
Celem projektu jest stworzenie nowoczesnej, responsywnej aplikacji webowej umożliwiającej kompleksową obsługę klientów salonu samochodowego, serwisu oraz sklepu internetowego. System ma na celu usprawnienie procesów sprzedaży samochodów i części oraz zarządzanie usługami serwisowymi. Projekt ma również zwiększyć dostępność oferty firmy poprzez umożliwienie klientom korzystania z usług online w sposób szybki, wygodny i bezpieczny.

=== Zakres projektu:
Zakres projektu obejmuje zaprojektowanie i implementację trzech głównych modułów:

+ *Salon samochodowy* - prezentacja oferty pojazdów, możliwość rezerwacji jazdy próbnej.
+ *Serwis samochodowy* - system rezerwacji wizyt, przeglądów i napraw, oferta serwisowa oraz historia serwisowa pojazdu.
+ *Sklep internetowy* - sprzedaż części i akcesoriów samochodowych, wyszukiwanie i filtrowanie produktów, dodawanie do koszyka, płatności online i wystawianie opinii.

Dodatkowo system będzie wspierał rejestrację i logowanie użytkowników oraz zarządzanie kontem.

== Słownik pojęć

#table(
  columns: (1fr, 1fr, 2fr),
  align: (left, left, left),
  table.header([*Termin*], [*Synonimy*], [*Definicja terminu*]),
  [Salon samochodowy], [Salon], [Salon samochodowy, dla którego projektowany jest system.],
  [Sklep internetowy], [Sklep internetowy salonu], [Sklep internetowy, który należy do salonu.],
  [Serwis samochodowy], [Serwis salonu], [Serwis samochodowy, który należy do salonu.],
  [Produkt], [Przedmiot, Artykuł], [Produkt sprzedawany w sklepie internetowym salonu.],
  [Samochód],
  [Auto, Pojazd],
  [Podmiot sprzedawany w sklepie internetowym lub w salonie oraz obsługiwany w salonie i w serwisie salonu.],

  [Usługa],
  [Czynność serwisowa],
  [Działanie oferowane klientowi przez serwis lub salon, np. naprawa, przegląd, montaż lub sprzedaż produktu.],

  [Wizyta],
  [Zaplanowane spotkanie],
  [Zaplanowane spotkanie klienta w serwisie lub salonie, np. w celu wykonania przeglądu, naprawy lub jazdy próbnej.],

  [Koszyk internetowy],
  [Koszyk zakupowy],
  [Element sklepu internetowego, w którym użytkownik gromadzi wybrane produkty przed dokonaniem zakupu.],

  [Konto],
  [Profil, Konto użytkownika],
  [Indywidualny profil w systemie zawierający dane osobowe użytkownika, historię zamówień, rezerwacji oraz ustawienia konta.],

  [Użytkownik],
  [Klient, Konsument],
  [Osoba korzystająca z funkcjonalności systemu - może przeglądać ofertę, rezerwować wizyty, składać zamówienia i dokonywać płatności.],

  [Opinia],
  [Komentarz],
  [Treść zamieszczona przez użytkownika po zakupie lub skorzystaniu z usługi, wyrażająca jego ocenę i doświadczenie.],

  [Płatność internetowa],
  [Transakcja online, Płatność elektroniczna],
  [Sposób zapłaty za produkty lub usługi poprzez system płatności internetowych, np. Przelewy24, PayU, BLIK.],

  [Rejestracja użytkownika],
  [Tworzenie konta],
  [Proces tworzenia nowego konta w systemie poprzez podanie danych osobowych i ustawienie hasła.],

  [Logowanie],
  [Autoryzacja, Logowanie do systemu],
  [Proces uwierzytelnienia użytkownika w systemie w celu uzyskania dostępu do funkcji indywidualnych, np. historii zakupów.],

  [Historia serwisowa pojazdu],
  [Historia napraw, Historia przeglądów],
  [Zestawienie wszystkich usług serwisowych i napraw wykonanych dla danego pojazdu.],

  [Administrator systemu],
  [Admin, Zarządca],
  [Osoba odpowiedzialna za zarządzanie systemem, nadzór nad użytkownikami, ofertami, serwisem i poprawnym działaniem aplikacji.],

  [Zamówienie],
  [Transakcja, Zakup],
  [Zbiór danych dotyczących zakupu dokonany przez użytkownika w sklepie internetowym, obejmujący listę produktów, formę płatności i dane dostawy.],

  [Dostawa],
  [Wysyłka, Przesyłka],
  [Proces przekazania zakupionych produktów użytkownikowi, realizowany przez firmę kurierską lub odbiór osobisty w salonie.],

  [Reklamacja],
  [Zgłoszenie, Skarga],
  [Zgłoszenie przez użytkownika problemu z zakupionym produktem lub wykonaną usługą w celu naprawy, wymiany lub zwrotu.],

  [Cennik], [Lista cen, Katalog usług], [Zestawienie usług i produktów wraz z ich aktualnymi cenami w systemie.],
  [Historia zakupów],
  [Historia zamówień],
  [Zestawienie wszystkich transakcji dokonanych przez użytkownika w sklepie internetowym.],
)

= Specyfikacja i analiza wymagań

== Definicja wymagań funkcjonalnych

=== System salonu samochodowego

- Użytkownik ma możliwość rejestracji w systemie
- Użytkownik ma możliwość logowania do systemu
- Użytkownik ma możliwość zmiany hasła do swojego konta w systemie
- Użytkownik ma możliwość usunięcia swojego konta z systemu

=== Sklep internetowy salonu

- Użytkownik ma możliwość przeglądania katalogu części samochodowych w sklepie internetowym salonu
- Użytkownik ma możliwość wyszukiwania produktów w sklepie internetowym salonu
- Użytkownik ma możliwość dodawania i usuwania produktów z koszyka w sklepie internetowym salonu
- Użytkownik ma możliwość wystawiania opinii produktom w sklepie internetowym salonu
- Użytkownik ma możliwość dokonywania płatności internetowych podczas dokonywania zakupu produktów w sklepie internetowym salonu
- Użytkownik ma możliwość składania reklamacji w sklepie internetowym salonu
- Użytkownik ma możliwość wprowadzania danych dostawy w sklepie internetowym salonu
- Użytkownik ma możliwość otrzymywania drogą mailową potwierdzenia złożenia zamówienia w sklepie internetowym salonu
- Użytkownik ma możliwość przeglądania historii zakupów w sklepie internetowym

=== Serwis samochodowy salonu

- Użytkownik ma możliwość rezerwacji wizyty w serwisie salonu (wraz z wyborem rodzaju wizyty [przegląd, naprawa, wymiana opon], opisaniem przyczyny wizyty, podaniem szczegółów technicznych samochodu)
- Użytkownik ma możliwość anulowania zarezerwowanej wizyty w serwisie salonu nie krócej niż na 48 godzin przed zaplanowaną wizytą
- Użytkownik ma możliwość przeglądania historii wizyt w serwisie samochodowym
- Użytkownik ma możliwość przeglądania cennika usług w serwisie samochodowym

=== Salon samochodowy

- Użytkownik ma możliwość rezerwacji wizyty w salonie (wraz z wyborem rodzaju wizyty [jazda testowa, konsultacje, zakup samochodu])
- Użytkownik ma możliwość anulowania zarezerwowanej wizyty w salonie nie krócej niż na 48 godzin przed zaplanowaną wizytą
- Użytkownik ma możliwość przeglądania historii wizyt w salonie
- Użytkownik ma możliwość przeglądania ofert samochodów z salonu

== Wymagania niefunkcjonalne

- Przechowywane hasła muszą być zaszyfrowane
- Musi być wykorzystywane połączenie HTTPS
- Aplikacja powinna poprawnie działać na urządzeniach mobilnych
- System powinien obsługiwać polską i angielską wersję językową
- System powinien obsługiwać zmienną liczbę użytkowników, którzy z niego korzystają w tym samym momencie (powinien być w stanie obsłużyć dużą liczbę użytkowników na raz)

== Model informacyjny

#figure(
  image("imgs/image.png", width: 100%),
  caption: [Model informacyjny systemu]
)

== Reguły biznesowe i ograniczenia systemowe

=== Ogólne reguły biznesowe

- Każdy użytkownik musi posiadać konto w systemie, aby korzystać z funkcji rezerwacji wizyt, zakupów i wystawiania opinii.
- E-mail użytkownika musi być unikalny w systemie.
- Administrator ma pełne uprawnienia do zarządzania użytkownikami, produktami, usługami, zamówieniami i wizytami.
- Użytkownik może posiadać wiele rezerwacji, lecz nie może mieć dwóch wizyt w tym samym czasie.

=== Serwis salonu

- Użytkownik ma możliwość anulowania zarezerwowanej wizyty w serwisie salonu nie krócej niż na 48 godzin przed zaplanowaną wizytą
- Każda wizyta musi mieć przypisany status: „Zarezerwowana", „W realizacji", „Zakończona" lub „Anulowana".
- System nie pozwala na rezerwację wizyty w czasie, gdy warsztat jest poza godzinami pracy (np. 8:00–18:00).
- Serwis może mieć ograniczoną liczbę dostępnych terminów dziennie – po ich wykorzystaniu rezerwacja nie jest możliwa.

=== Salon samochodowy

- Użytkownik może dokonać rezerwacji wizyty w salonie (jazda próbna, konsultacja, zakup), wybierając dostępny termin i model samochodu.
- Rezerwacja wizyty w salonie może być anulowana najpóźniej 48 godzin przed terminem spotkania.
- Samochody niedostępne (sprzedane lub wycofane) nie mogą być rezerwowane ani dodawane do koszyka.

=== Sklep internetowy

- Produkt może być dodany do koszyka tylko, jeśli jest dostępny w magazynie (stan > 0).
- Użytkownik może w jednym zamówieniu kupować wiele produktów.
- Każde zamówienie ma przypisany unikalny numer i powiązanie z użytkownikiem.
- Użytkownik może wystawić jedną opinię do jednego produktu po jego zakupie.
- Reklamacja może być złożona tylko do produktów, które zostały wcześniej zakupione przez użytkownika.

=== Ograniczenia systemowe

- System wymaga połączenia z Internetem do poprawnego działania funkcji sklepu i płatności.
- Dane użytkowników, wizyt i zamówień są przechowywane w relacyjnej bazie danych.
- W celu bezpieczeństwa wszystkie hasła użytkowników są szyfrowane.

= Prototypy interfejsu


