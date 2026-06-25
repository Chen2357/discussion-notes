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

#let exercise-counter = counter("exercise")

#let exercise(title: none, body) = {
  exercise-counter.step()
  showybox(
    frame: (
      border-color: indigo,
      title-color: indigo,
      body-color: white.darken(10%),
      thickness: (left: 2pt),
      radius: 0pt
    ),
    title: if title != none {
      [Exercise #context exercise-counter.display(): #title]
    } else {
      [Exercise #context exercise-counter.display()]
    },
    title-style: (
      sep-thickness: 0pt,
    ),
    body,
  )
}

#set table(
  stroke: none,
  gutter: 0.1em,
  fill: gray.lighten(70%),
  columns: (1fr, 20pt, 20pt, 20pt, 20pt, 20pt)
)

#let head() = table.header(
  table.cell(align: center)[],
  table.cell(align: center)[1],
  table.cell(align: center)[2],
  table.cell(align: center)[3],
  table.cell(align: center)[4],
  table.cell(align: center)[5],
)

#let g(body) = table.cell(colspan: 6, fill: none, align: center, inset: 2pt, text(size: 8pt, body))

#let f(..items) = items.pos().map(x => (x, [], [], [], [], [])).flatten()

#let textbook(number) = text(blue, style: "italic")[(#number)]

#set enum(numbering: "(a)")

#let author = "Chen Liang"
#let date = datetime(year: 2026, month: 3, day: 12)

#set document(
  title: [MAT 21D Final Review],
  author: author,
  date: date,
)

#show title: it => text(18pt, weight: "bold", it)

#place(top + center, float: true, {
  set align(center)
  title()
  author
  linebreak()
  date.display("[month repr:long] [day], [year]")
})

= How to use this review guide

This worksheet organizes lecture notes into topics and break down the skills you are expected to learn into topics.

= Double integrals in rectangular coordinates

