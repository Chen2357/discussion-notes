#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt)
#import "@preview/numty:0.1.0" as nt

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)

  let dx = 0.2
  let N = 13
  let x-bound = N * dx + 0.2
  let y-bound = 2.3
  let y-scale = 80

  axis((0, 0), (x-bound, 0))
  axis((0, 0), (0, y-bound))

  let a(n) = calc.pow(n, 2) / y-scale
  let mark = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let mark-radius = 0.05

  let fun-N = 100
  let points = ()
  for x in nt.linspace(0, x-bound - 0.2, fun-N) {
    let y = calc.pow(x / dx, 2) / y-scale
    points.push((x, y))
  }
  let fun-line = line.with(stroke: (thickness: 0.5pt, paint: red.darken(20%)))
  fun-line(..points)
  content((), anchor: "east")[#text(red.darken(20%))[$y = x^2$]]

  for n in range(1, N) {
    let x = n * dx
    let y = a(n)

    mark((x, -mark-radius), (x, mark-radius))
    content((x, -mark-radius), anchor: "north", padding: (top: 2pt))[#text(7pt)[$#n$]]

    point((x, y))
  }

  let limit-line = line.with(stroke: (
    thickness: 1pt,
    paint: red.transparentize(50%),
    dash: "dashed",
  ))
  // limit-line((-mark-radius, 1), (x-bound, 1))
  // content((-mark-radius, 1), anchor: "east", padding: (right: 2pt))[$#y-scale$]
})
