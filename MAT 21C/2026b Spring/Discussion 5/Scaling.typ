#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt), fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  
  let a = (2, 0)

  let vector = line.with(stroke: (thickness: 1.2pt, paint: black), mark: (end: "stealth"), fill: black)
  let aux = line.with(stroke: (thickness: 1.2pt, paint: gray), mark: (end: "stealth"), fill: gray)

  vector((0, 0), a)
  content(nt.mult(a, 0.5), anchor: "south", padding: (bottom: 2pt))[$arrow(a)$]
  
  let gap = -0.2
  vector((0, gap), (rel: nt.mult(a, 0.5)))
  content(nt.add((0, gap), nt.mult(a, 0.25)), anchor: "north", padding: (top: 5pt))[$1/2 arrow(a)$]

  vector((0, gap * 2), (rel: nt.mult(a, -1)))
  content(nt.add((0, gap * 2), nt.mult(a, -0.5)), anchor: "south", padding: (bottom: 5pt))[$-arrow(a)$]
 })
