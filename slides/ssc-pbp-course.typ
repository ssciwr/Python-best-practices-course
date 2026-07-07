#import "@preview/touying:0.7.4": *
#import "ssc-theme.typ": *

#show: institution-theme.with(
  title-logo: image("ssc_iwr_uni_logos_darkmode.svg"),
  slide-logo: image("ssc_logo_and_text.svg"),
  config-info(
    title: [Best Practices in Python Programming],
    author: [Thomas Isensee],
    date: datetime.today(),
    institution: [Scientific Software Center (SSC), Heidelberg University],
  ),
)

// ============
// Font styling
// ============
#set text(
  font: ("Source Sans 3"),
)

// =============
// Block styling
// =============
#show raw.where(block: false): box.with(
  fill: luma(80.78%),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 4pt,
)

#show raw.where(block: true): it => block(
  fill: luma(80.78%),
  inset: 12pt,
  radius: 8pt,
  text(size: 12pt, it),
)
#set raw(theme: auto)

// =============
// Slide styling
// =============
#set heading(numbering: "1.1")

// ==============
// Begin document
// ==============

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= Prerequisites

== First Slide

A #link("https://www.ssc.uni-heidelberg.de/en")[hyperlink].

#lorem(30)

#slide(
  composer: (2fr, 1fr),
  title: "Second Slide"
)[#lorem(30)][#lorem(30)]


#slide(
  title: "Third Slide",
)[
  ```python
  # you can also explicitly convert the iterator to a list
  # not recommended for large iterators
  def exhaust_my_iterators(days, lunch):
      menu = list(zip(days, lunch))
      print("Printing the list(menu):", list(menu))
      full_menu = []
      print("Printing the menu item by item:")
      for item in menu:  # now the "menu" is not exhausted before the loop
          print("On {} we offer {} for lunch.".format(item[0], item[1]))
          full_menu.append((item[0], item[1]))
      return full_menu
  ```
]

= Python Enhancement Proposals (PEPs)
== Test
#raw("def test()", block: false)
= Linter
= Formatter
= Common Pitfalls
= Better Coding
