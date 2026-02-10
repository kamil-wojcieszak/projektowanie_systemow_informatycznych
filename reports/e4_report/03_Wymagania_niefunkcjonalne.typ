= Wymagania niefunkcjonalne

== Przechowywane hasła muszą być bezpieczne

#image("images/hash.png", width: 100%)

== System powinien zapewniać bezpieczne przesyłanie informacji

Https na frontendzie:
#image("images/03_https_frontend.png", width: 100%)

Https na backendzie:
#image("images/03_https_backend.png", width: 100%)

== Aplikacja powinna poprawnie działać na urządzeniach mobilnych

#image("images/03_responsive_1.jpg", width: 100%)

#image("images/03_responsive_2.jpg", width: 100%)

== System powinien obsługiwać dwie wersje językowe

#image("images/polski.png", width: 100%)

#image("images/angielski.png", width: 100%)

Funkcja obsługi dwóch wersji językowych w aplikacji została zrealizowana (niestety nie zdążyliśmy dodać tłumaczenia na każdym ekranie/każdego wyrazu w aplikacji) z wykorzystaniem biblioteki *react-i18next*, która umożliwia dynamiczne tłumaczenie interfejsu użytkownika w aplikacjach React.

W projekcie utworzono pliki słowników językowych w formacie JSON (dla języka polskiego i angielskiego), zawierające wszystkie statyczne teksty występujące w interfejsie, takie jak nazwy przycisków, nagłówki, etykiety formularzy oraz elementy nawigacji.

W komponentach React wykorzystano hook `useTranslation`, który pozwala pobierać odpowiednie tłumaczenia za pomocą funkcji `t("klucz")`. Dzięki temu tekst wyświetlany użytkownikowi automatycznie zmienia się w zależności od wybranego języka.

Zmiana języka odbywa się dynamicznie — po kliknięciu przycisku wywoływana jest metoda `i18n.changeLanguage()`, co powoduje natychmiastowe przeładowanie tłumaczeń bez konieczności odświeżania strony.

Wartości dynamiczne, takie jak dane produktów lub kategorii pobierane z backendu, nie są tłumaczone po stronie frontendowej. Zakłada się, że pozostają one niezależne od języka interfejsu.
