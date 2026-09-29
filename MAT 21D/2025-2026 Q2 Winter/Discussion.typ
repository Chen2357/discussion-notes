#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2" as cetz
#import "@preview/physica:0.9.8" as physica: pdv
#import "@preview/numty:0.1.0" as nt

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#let indigo = rgb(109, 107, 135)
#let red = rgb(199, 56, 52)
#let blue = rgb(15, 101, 160)
#let dark-magenta = rgb(104, 81, 120)

#let exercise(body) = showybox(
  frame: (
    border-color: indigo,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#let theorem(body) = showybox(
  frame: (
    border-color: red,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#let solution(body, label: "Solution") = {
  text(red, style: "italic")[#label.]
  body
}

#let remark(body, label: "Remark") = showybox(
  frame: (
    border-color: yellow,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#let bf(it) = math.bold(math.upright(it))
#let dd(..args) = physica.dd(..args, d: $d$)
#let dv(..args) = physica.dv(..args, d: $d$)

#let discussion(
  number: auto,
  author: "Chen Liang",
  date: datetime.today(),
  doc,
) = {
  set par(justify: true)

  set heading(numbering: "§I")
  show heading: set block(below: 1em)

  set document(
    title: [MAT 21D Discussion #number Notes],
    author: author,
    date: date,
  )

  show title: it => text(18pt, weight: "bold", it)

  place(top + center, float: true, {
    set align(center)
    title()
    author
    linebreak()
    date.display("[month repr:long] [day], [year]")
  })

  doc
}
