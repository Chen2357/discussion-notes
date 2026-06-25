#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt), fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  
  let a = (0.4, 2)
  let b = (1.5, 0)

  let vector(color: black, ..args) = line(stroke: (thickness: 1.2pt, paint: color), mark: (end: "stealth"), fill: color, ..args)
  let aux = line.with(stroke: (thickness: 1.2pt, paint: gray), mark: (end: "stealth"), fill: gray)

  vector((0, 0), a)
  content(nt.mult(a, 0.5), anchor: "east", padding: (right: 5pt))[$arrow(a)$]
  vector((0, 0), b)
  content(nt.mult(b, 0.5), anchor: "north", padding: (top: 5pt))[$arrow(b)$]

  vector(b, a, color: red)
  content(nt.add(b, nt.mult(nt.sub(a, b), 0.5)), anchor: "south-west", padding: (left: 1.5pt))[#set text(red); $arrow(a) - arrow(b)$]

  aux(a, nt.sub(a, b))
  content(nt.sub(a, nt.mult(b, 0.5)), anchor: "south", padding: (bottom: 1.5pt))[#text(gray)[$-arrow(b)$]]

  vector((0, 0), nt.sub(a, b), color: red)
  content(nt.mult(nt.sub(a, b), 0.5), anchor: "north-east", padding: (right: 5pt))[#set text(red); $arrow(a) - arrow(b)$]
})
