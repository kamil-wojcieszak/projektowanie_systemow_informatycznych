= Analiza wybranych scenariuszy

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: A2], table.cell(colspan: 4)[Wsparcie dla co najmniej 1 000 równoczesnych użytkowników bez spadku wydajności.],
    
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
    [Analiza], table.cell(colspan: 4)[Autoskalowanie frontendu i load balancer eliminują przeciążenia przy dużym ruchu. Ryzyko R3 występuje przy opóźnionej synchronizacji skalowania.],
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