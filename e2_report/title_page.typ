// Title page with optional date parameter
#let title_page(
  date: "null",
  title: "null",
  lecturer: "null",
  authors: ("null","null")
) = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )

  set text(font: "New Computer Modern", size: 11pt)

  v(1cm)

  image("images/logo_pwr.svg", width: 100%)

  v(3cm)

  align(center)[
    #text(size: 20pt, weight: "regular")[
      #title
    ]

    #v(1.5cm)

    #line(length: 100%, stroke: 0.5pt)


    #text(size: 24pt, weight: "bold")[
      Sprawozdanie
    ]

    #line(length: 100%, stroke: 0.5pt)
  ]

  v(1fr)

  align(right)[
    #text(style: "italic", size: 11pt)[Prowadzący:] \
    #text(size: 11pt)[#lecturer]

    #v(0.5cm)

    #text(style: "italic", size: 11pt)[Wykonali:] \
    #text(size: 11pt)[
      #authors.join(linebreak())
    ]
  ]

  v(1fr)

  align(center)[
    #text(size: 11pt)[
      Wrocław, #date
    ]
  ]

  pagebreak()
}
