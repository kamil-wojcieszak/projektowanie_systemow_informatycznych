= Ryzyka i nie-ryzyka

== Ryzyka

- *Baza danych jako potencjalne wąskie gardło*  

  Przy dużej liczbie użytkowników jednocześnie korzystających z systemu, na przykład podczas równoczesnego rozwiązywania testów, relacyjna baza danych może stać się elementem ograniczającym wydajność całego systemu.

- *Brak mechanizmu cache*  

  W zaprojektowanej architekturze nie przewidziano dodatkowej warstwy pamięci podręcznej, co może prowadzić do częstych odwołań do bazy danych oraz zwiększonego obciążenia warstwy backendowej.

- *Złożoność infrastruktury*  
 
  Wykorzystanie mechanizmów autoskalowania, load balancingu oraz klastrów baz danych zwiększa stopień skomplikowania infrastruktury, co może utrudniać jej utrzymanie, monitorowanie oraz diagnozowanie błędów.

- *Rzadkie pełne kopie zapasowe bazy danych*

  Pełne kopie zapasowe wykonywane są raz w miesiącu. W przypadku poważnej awarii lub błędu logicznego możliwa jest utrata danych z dłuższego okresu czasu, mimo wykonywania kopii przyrostowych.

- *Brak jawnie opisanych mechanizmów monitoringu*

  Brak szczegółowo opisanych mechanizmów monitoringu i alertowania może utrudniać szybkie wykrywanie problemów wydajnościowych i dostępnościowych.

== Nie-ryzyka

- *Skalowalność aplikacji*  
 
  Dzięki uruchomieniu systemu w architekturze wieloinstancyjnej oraz zastosowaniu mechanizmów autoskalowania, aplikacja jest przygotowana na wzrost liczby użytkowników.

- *Bezpieczeństwo haseł*  
 
  Hasła użytkowników są przechowywane w postaci bezpiecznych skrótów z wykorzystaniem algorytmu bcrypt, co znacząco zmniejsza ryzyko ich przejęcia w przypadku naruszenia bezpieczeństwa.

- *Dostępność systemu*  
 
  Zastosowanie load balancera umożliwia utrzymanie ciągłości działania systemu nawet w przypadku awarii pojedynczej instancji aplikacji.

- *Przechowywanie multimediów poza bazą danych*

  Pliki są w Amazon S3, nie w PostgreSQL. Wydzielenie plików multimedialnych do magazynu obiektowego ogranicza ryzyko problemów wydajnościowych bazy danych.

- *Jasna separacja warstw systemu*

  Zmiany w jednej warstwie nie wymuszają zmian w pozostałych. Architektura warstwowa zmniejsza ryzyko niekontrolowanych zależności pomiędzy komponentami systemu.