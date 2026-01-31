= Analiza wybranych scenariuszy

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: A1], table.cell(colspan: 4)[Wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności.],
    
    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[Wydajność, Skalowalność],
    
    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],
    
    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[Jednoczesne korzystanie z systemu przez ≥1000 użytkowników],
    
    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[Frontend i backend skalują się automatycznie, aby zapewnić obsługę równoczesnych połączeń bez spadku jakości usług.],
    
    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],
    
    // Wiersz 7
    [Autoskalowanie frontend], [S1], [T1], [R1], [],
    
    // Wiersz 8
    [Load balancer], [S2], [T2], [], [N1],
    
    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[Autoskalowanie frontendu i load balancer eliminują przeciążenia przy dużym ruchu. Ryzyko R1 występuje przy opóźnionej synchronizacji skalowania.],
  ),
)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: A2], table.cell(colspan: 4)[Zapewnienie dostępu do aplikacji przez co najmniej 99% czasu],

    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[Dostępność],

    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],

    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[Awaria pojedynczej instancji backendu lub frontendu],

    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[Ruch użytkowników zostaje automatycznie przekierowany do pozostałych instancji aplikacji, zapewniając ciągłość działania systemu.],

    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],

    // Wiersz 7
    [Load Balancer], [S3], [T3], [R2], [N2],

    // Wiersz 8
    [Wieloinstancyjne wdrożenie backendu i frontendu], [S4], [T4], [R3], [N3],

    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[Wieloinstancyjne wdrożenie wraz z load balancerem eliminuje pojedynczy punkt awarii, zwiększając dostępność systemu. Ryzyka R2 i R3 dotyczą błędnej konfiguracji load balancera lub niewłaściwego wdrożenia instancji, natomiast N2 i N3 zapewniają dostępność na poziomie ≥99%.],
  ),
)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: B1], table.cell(colspan: 4)[Wartości haseł wszystkich użytkowników nie
mogą być możliwe do przeczytania],
    
    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[Bezpieczeństwo],
    
    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],
    
    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[Zagrożenie związane z próbą odczytania haseł zarejestrowanych użytkowników],
    
    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[Przechowywanie haseł w postaci skrótów bcrypt z losową solą],
    
    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],
    
    // Wiersz 7
    [Skróty bcrypt z solą], [S5], [T5], [], [],
    
    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[],
  ),
)


#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: B1], table.cell(colspan: 4)[],
    
    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[],
    
    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],
    
    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[],
    
    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[],
    
    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],
    
    // Wiersz 7
    [], [], [], [], [],
    
    // Wiersz 8
    [], [], [], [], [],
    
    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[],
  ),
)