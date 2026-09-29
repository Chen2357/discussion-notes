#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt), fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  
  let a = (0.4, 2)
  let b = (1.5, 0)

  let vector(color: black, ..args) = line(stroke: (thickness: 1.2pt, paint: color), mark: (end: "stealth"), fill: color, ..args)
  let aux = line.with(stroke: (thickness: 1.2pt, paint: gray, dash: "dashed"), fill: gray)

  vector((0, 0), a)
  content(nt.mult(a, 0.5), anchor: "east", padding: (right: 5pt))[$arrow(a)$]
  vector((0, 0), b)
  content(nt.mult(b, 0.5), anchor: "north", padding: (top: 5pt))[$arrow(b)$]

  aux(a, nt.add(a, b))
  aux(b, nt.add(a, b))
  aux(b, a)
  aux((0, 0), nt.add(a, b))

  // vector((0, 0), nt.mult(nt.add(a, b), 0.5), color: red)
  // content(nt.mult(nt.add(a, b), 0.25), anchor: "north-west", padding: (left: 5pt))[#set text(red); ?]
  vector(a, (rel: nt.mult(0.5, nt.sub(a, b))), color: blue)
  content(nt.add(a, nt.mult(0.25, nt.sub(a, b))), anchor: "west", padding: (left: 5pt))[#set text(blue); $1/2 (arrow(a) - arrow(b))$]

  vector(b, (rel: nt.mult(0.5, nt.sub(a, b))), color: blue)
  content(nt.add(b, nt.mult(0.25, nt.sub(a, b))), anchor: "west", padding: (left: 5pt))[#set text(blue); $1/2 (arrow(a) - arrow(b))$]

  vector(a, (rel: nt.mult(-0.5, nt.sub(a, b))), color: red)
  content(nt.add(a, nt.mult(-0.25, nt.sub(a, b))), anchor: "west", padding: (left: 5pt))[#set text(red); $-1/2 (arrow(a) - arrow(b))$]

  vector(b, (rel: nt.mult(-0.5, nt.sub(a, b))), color: red)
  content(nt.add(b, nt.mult(-0.25, nt.sub(a, b))), anchor: "west", padding: (left: 5pt))[#set text(red); $1/2 (arrow(b) - arrow(a))$]
})


