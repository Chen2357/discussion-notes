#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt), fill: white.transparentize(100%))
#set math.accent(dotless: false)

#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  let axis = line.with(stroke: (thickness: 0.8pt, paint: black), mark: (end: "stealth"), fill: black)
  axis((0, 0), (14, 0))
  axis((0, 0), (0, 12))

  for x in range(1, 14) {
    for y in range(1, 12) {
      circle((x, y), radius: 1pt, fill: gray, stroke: none)
    }
  }
  
  let base = (3, 2)
  let base2 = (1, 4)
  let v = (8, 6)

  let vector(color: black, ..args) = line(stroke: (thickness: 1.2pt, paint: color), mark: (end: "stealth"), fill: color, ..args)
  vector(base, nt.add(base, v), color: red)
  content(nt.add(base, nt.mult(v, 0.5)), anchor: "south", padding: (right: 10pt))[#set text(red); $arrow(v)$]
  vector(base2, nt.add(base2, v), color: red)
  content(nt.add(base2, nt.mult(v, 0.5)), anchor: "south", padding: (right: 10pt))[#set text(red); $arrow(v)$]
  
  for x in range(base.at(0), base.at(0) + v.at(0)) {
    vector((x, base.at(1)), (rel: (1, 0)))
  }
  content(nt.add(base, (0.5, 0)), anchor: "north", padding: (top: 7pt))[$hat(i)$]
  for y in range(base.at(1), base.at(1) + v.at(1)) {
    vector((base.at(0) + v.at(0), y), (rel: (0, 1)))
  }
  content(nt.add(base, (v.at(0), 0.4)), anchor: "west", padding: (left: 5pt))[$hat(j)$]
})
