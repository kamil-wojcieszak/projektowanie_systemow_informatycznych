= Widok funkcjonalny

Diagram komponentów

// XXX zdjecie diagramu komponentów XXX
#figure(
 image("images/E2_6_widok_funkcjonalny_v2.drawio.png"),
 // caption: [Diagram komponentów]
)

Niebieskie połączenia na powyższym diagramie symbolizują komunikację między Account Service, a pozostałymi serwisami.

\
#text(weight: "bold")[
    Rola serwisów:
    ] \
- Internet shop service (serwis sklepu internetowego)
    - możliwość przeglądania katalogu części samochodowych w sklepie internetowym salonu
    - możliwość dodawania i usuwania produktów z koszyka w sklepie internetowym salonu 
    - możliwość wystawiania opinii produktom w sklepie internetowym salonu 
    - możliwość zakupu produktów (części) w sklepie internetowym salonu

- Car showroom and service service (serwis salonu i serwisu samochodowego)
    - możliwość rezerwacji wizyty w salonie samochodowym (wraz z wyborem rodzaju wizyty [jazda próbna, konsultacja, zakup], wybór terminu wizyty spośród dostępnych)
    - możliwość przeglądania oferty salonu
    - możliwość rezerwacji wizyty w serwisie salonu (wraz z wyborem rodzaju wizyty [przegląd, naprawa, wymiana opon, wymiana oleju], opisaniem przyczyny wizyty, podaniem szczegółów technicznych samochodu)
    - możliwość przeglądania cennika usług w serwisie samochodowym

- Account service (serwis kont użytkowników)
    - możliwość rejestracji i logowania się do systemu