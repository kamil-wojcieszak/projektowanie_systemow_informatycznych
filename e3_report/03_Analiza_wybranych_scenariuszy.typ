= Analiza wybranych scenariuszy

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: A1], table.cell(colspan: 4)[System musi obsłużyć wzmożony ruch użytkowników w okresach szczytowych],
    
    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[Wydajność, Skalowalność],
    
    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],
    
    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[Jednoczesne korzystanie z systemu przez ponad 1000 użytkowników],
    
    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[System utrzymuje średni czas odpowiedzi API na poziomie 300 ms (95 percentyl) bez spadku dostępności usług.],
    
    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],
    
    // Wiersz 7
    [Auto Scaling Group – Backend], [S1], [T1], [], [N1],
    
    // Wiersz 8
    [Auto Scaling Group – Frontend], [S2], [T2], [R1], [],
    
    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[Zastosowanie autoskalowania backendu i frontendu umożliwia dynamiczne dostosowanie zasobów do aktualnego obciążenia systemu. Wrażliwość S1 i S2 dotyczy poprawnej konfiguracji progów skalowania. Ryzyko R1 występuje w przypadku zbyt wolnej reakcji autoskalera, co może prowadzić do chwilowych opóźnień odpowiedzi systemu.],
  ),
)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: 1pt,
    inset: 6pt,
    
    // Wiersz 1
    [Scenariusz: A1], table.cell(colspan: 4)[System musi obsłużyć wzmożony ruch użytkowników w okresach szczytowych],
    
    // Wiersz 2 (scalone 2-2 do 2-5)
    [Atrybuty], table.cell(colspan: 4)[Wydajność, Skalowalność],
    
    // Wiersz 3
    [Środowisko], table.cell(colspan: 4)[Normalny tryb pracy],
    
    // Wiersz 4
    [Bodziec], table.cell(colspan: 4)[Jednoczesne korzystanie z systemu przez ponad 1000 użytkowników],
    
    // Wiersz 5
    [Odpowiedź], table.cell(colspan: 4)[System utrzymuje średni czas odpowiedzi API na poziomie 300 ms (95 percentyl) bez spadku dostępności usług.],
    
    // Wiersz 6
    [Decyzje architektoniczne], [Wrażliwość], [Kompromis], [Ryzyko], [Brak ryzyka],
    
    // Wiersz 7
    [Auto Scaling Group – Backend], [S1], [T1], [], [N1],
    
    // Wiersz 8
    [Auto Scaling Group – Frontend], [S2], [T2], [R1], [],
    
    // Wiersz 9
    [Analiza], table.cell(colspan: 4)[Zastosowanie autoskalowania backendu i frontendu umożliwia dynamiczne dostosowanie zasobów do aktualnego obciążenia systemu. Wrażliwość S1 i S2 dotyczy poprawnej konfiguracji progów skalowania. Ryzyko R1 występuje w przypadku zbyt wolnej reakcji autoskalera, co może prowadzić do chwilowych opóźnień odpowiedzi systemu.],
  ),
)
