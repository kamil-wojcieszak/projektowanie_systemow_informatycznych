= Punkty wrażliwości i kompromisy

*S1:* Autoskalowanie frontendowe jest wrażliwe na opóźnioną reakcję przy gwałtownym wzroście ruchu, co może skutkować chwilowym przeciążeniem serwerów i spadkiem wydajności dla użytkowników końcowych.

*S2:* Load balancer wymaga prawidłowej konfiguracji rozdzielania ruchu; niewłaściwe ustawienia mogą prowadzić do nierównomiernego obciążenia instancji i częściowych przerw w dostępności usług.

*S3:* Load balancer jest wrażliwy na awarie lub nieprawidłowe health checki, co może skutkować kierowaniem ruchu do niedostępnych instancji lub chwilową utratą możliwości obsługi żądań użytkowników.

*S4:* Wieloinstancyjne wdrożenie backendu i frontendu wymaga spójnego zarządzania stanem aplikacji; brak synchronizacji lub błędy w konfiguracji mogą prowadzić do niespójności danych lub przerw w działaniu funkcji systemu.

*S5:* Zbyt niski koszt bcrypt zmniejsza odporność na ataki brute force natomiast zbyt wysoki prowadzi do problemów wydajnościowych przy logowaniu

*T1:* Zapewnia obsługę dużej liczby jednoczesnych połączeń kosztem większej złożoności infrastruktury, wymagając monitorowania zasobów i dynamicznej konfiguracji autoskalowania w odpowiedzi na zmieniające się obciążenie systemu.

*T2:* Poprawia dostępność systemu, ale wprowadza dodatkową warstwę pośrednią w architekturze, która wymaga utrzymania i monitoringu, a także może wprowadzać niewielki narzut czasowy w przetwarzaniu żądań.

*T3:* Umożliwia ciągłość działania systemu przy awarii pojedynczej instancji kosztem monitoringu i utrzymania, ponieważ wszystkie instancje muszą być stale nadzorowane pod kątem zdrowia i wydajności.

*T4:* Poprawia dostępność i skalowalność systemu kosztem złożoności wdrożenia i synchronizacji instancji, wymagając dodatkowych mechanizmów koordynacji stanu aplikacji oraz procedur zapewniających spójność danych między instancjami.

*T5:* Zastosowanie bcrypt znacząco zwiększa odporność systemu na ataki brute force oraz uniemożliwia odtworzenie haseł w przypadku naruszenia bazy danych. Mechanizm powoduje zwiększenie czasu operacji uwierzytelniania w porównaniu do szybszych algorytmów skrótu, co musi być uwzględnione przy dużej liczbie równoczesnych logowań.