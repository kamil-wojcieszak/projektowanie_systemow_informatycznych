= Ryzyka i nie-ryzyka

*R1:* Opóźnione skalowanie frontendowych instancji może prowadzić do chwilowego spadku wydajności przy gwałtownym wzroście ruchu użytkowników, skutkując wydłużonym czasem odpowiedzi lub krótkotrwałym przeciążeniem serwerów.

*R2:* Nieprawidłowa konfiguracja load balancera może powodować nierównomierne rozdzielenie ruchu między instancje, prowadząc do częściowych przerw w dostępności usług lub nieefektywnego wykorzystania zasobów systemu.

*R3:* Błędne wdrożenie wielu instancji backendu lub frontendu może skutkować utratą ciągłości działania, np. przez niespójność danych między instancjami lub czasową niedostępność wybranych funkcjonalności aplikacji.

*R4:* Ryzyko spadku wydajności przy dużej liczbie równoczesnych logowań i zbyt wysokim koszcie bcrypt. To ryzyko może stać się również pomocne dla potencjalnego ataku DoS- atakujący mógłby generować masowe próby logowania i tym samym obciążyć instancję

*R5:* Ryzyko błędnego zarządzania certyfikatami. W przypadku wygaśnięcia certyfikatu system stanie się niedostępny

*R6:* Ryzyko błędnej konfiguracji load balancera i bram i tym samym oodrzucanie połączeń. Single Point of Failure

*N1:* Prawidłowo skonfigurowane autoskalowanie frontendu umożliwia obsługę co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności, zapewniając płynną pracę systemu nawet przy dużym obciążeniu.

*N2:* Load balancer poprawnie rozdzielający ruch zapewnia wysoką dostępność systemu, umożliwiając działanie aplikacji nawet w przypadku awarii pojedynczej instancji, minimalizując przestoje dla użytkowników.

*N3:* Wieloinstancyjne wdrożenie backendu i frontendu, w połączeniu z odpowiednią synchronizacją stanu, pozwala utrzymać dostępność systemu na poziomie ≥99% czasu, zapewniając ciągłość kluczowych usług platformy.

*N4:* Zastosowanie skrótów bcrypt uniemożliwia odtworzenie haseł w przypadku wycieku bazy danych

*N5:* Brak ryzyka podsłuchu komunikacji oraz ataków Man-in-the-Middle

*N6:* Brak możliwości modyfikacji przesyłanych danych, co zapewnia ich integralność 

*N7:* Brak ryzyka komunikacji nieszyfrowanej w którejś przestrzeni architektury