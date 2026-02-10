#import "title_page.typ": title_page


#title_page(
  date: "27 Styczeń 2026r.",
  title: "Wyniki etapu IV: Implementacja: 
  System do zarządzania działalnością salonu samochodowego

 ",
  lecturer: "dr inż. Bogumiła Hnatkowska",
  authors: (
    "Jakub Staniszewski 266876",
    "Kamil Wojcieszak 264487",
    "Kasjan Kardaś 263505"   
  )
)
#set page(numbering: "1 z 1")
#set heading(numbering: "1.1)")

#show figure.where(kind: image): set figure(supplement: [Rysunek])
#show figure.where(kind: table): set figure(supplement: [Tabela])

#outline(
  title: "Spis treści",
  indent: auto
)

#pagebreak()

#include "01_Zaimplementowane_serwisy.typ"
#include "02_Wymagania_funkcjonalne.typ"
#include "03_Wymagania_niefunkcjonalne.typ"
