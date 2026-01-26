#import "title_page.typ": title_page


#title_page(
  date: "26 Styczeń 2026r.",
  title: "Wyniki etapu III: Ocena architektury systemu: System e-learningowy",
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

#include "01_Przeglad_podejsc_architektonicznych.typ"
#include "02_Drzewo_uzytecznosci.typ"
#include "03_Analiza_wybranych_scenariuszy.typ"
#include "04_Punkty_wrazliwosci_i_kompromisy.typ"
#include "05_Ryzyka_i_nie-ryzyka.typ"
#include "06_Wnioski.typ"

