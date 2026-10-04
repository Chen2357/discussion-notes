#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#import "@preview/modpattern:0.1.0": modpattern
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#let hatched(size: (.2cm, .2cm), ..args) = modpattern(size, {
  std.line(start: (0%, 100%), end: (100%, 0%), ..args)
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))

  axis((0, 0), (6.4, 0))
  content((6.4, 0), anchor: "west", padding: (left: 2pt))[$x$]
  axis((0, 0), (0, 2))
  content((0, 2), anchor: "south", padding: (bottom: 2pt))[$y$]

  let tick = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let tick-radius = 0.1

  let f(n) = 1 / (calc.pow(n - 4, 2) + 1)
  let N = 1
  let dx = 0.6
  let x-start = dx

  let fun-num = 100
  let term-num = 9

  for i in range(term-num) {
    let n = N + i
    let x = x-start + i * dx
    let y = f(n)
    tick((x, -tick-radius), (x, tick-radius))
    if i == 0 {
      content((x, -tick-radius), anchor: "north", padding: (top: 2pt))[#text(5pt)[$#n$]]
    } else {
      content((x, -tick-radius), anchor: "north", padding: (top: 2pt))[#text(5pt)[$#n$]]
    }

    circle((x, y), radius: 1.5pt, fill: red, stroke: none)
  }


  let fun-points = nt.linspace(0 , 6.4 / dx, fun-num).map(n => (x-start + (n - N) * dx, f(n)))
  let draw-fun = line.with(stroke: (thickness: 0.5pt, paint: red.darken(20%)))
  draw-fun(..fun-points)

  content((8 * dx, 1.5))[$f(x) = 1/((x-4)^2 + 1)$]
})

