#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let river = line.with(stroke: 1pt + blue)
  let location = circle.with(radius: 2pt, fill: red, stroke: none)
  let a = (-0.2, 1)
  let b = (2.2, 1.5)

  river((-1, 0), (3, 0))
  content((), anchor: "south-east", padding: (bottom: 3pt))[#text(blue, 7pt)[River]]
  location(a)
  content((), anchor: "east", padding: (right: 5pt))[Town 1]
  location(b)
  content((), anchor: "west", padding: (left: 5pt))[Town 2]

  let path(x, ..args) = {
    on-layer(-1, {
      line(a, (x, 0), ..args)
      line((x, 0), b, ..args)
    })
  }


  let optimal-x = a.at(0) + a.at(1) * (b.at(0) - a.at(0)) / (a.at(1) + b.at(1))
  let option-1 = a.at(0)
  let option-2 = optimal-x
  let option-3 = 1.5
  let option-4 = b.at(0)
  let options = (option-1, option-2, option-3, option-4)
  let option-names = ("A", "B", "C", "D")
  let option-color = yellow.darken(50%)

  for (i, x) in options.enumerate() {
    let name = option-names.at(i)

    path(x, stroke: (thickness: 1pt, paint: option-color))
    content((x, 0), anchor: "north", padding: (top: 3pt))[#text(option-color, 7pt)[Option #name]]
  }
})
