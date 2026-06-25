#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt)
#import "@preview/numty:0.1.0" as nt

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)

  let x-scale = 0.2
  let N = 15
  let x-bound = N * x-scale + 0.2
  let y-bound = 1.2

  axis((0, 0), (x-bound, 0))
  axis((0, -y-bound), (0, y-bound))

  let a(n) = calc.pow(-1, n - 1) / n
  let mark = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let mark-radius = 0.05

  let fun-N = 100
  let curve1 = ()
  let curve2 = ()
  for pre-x in nt.linspace(1 / y-bound, N, fun-N) {
    let y = 1 / pre-x
    curve1.push((pre-x * x-scale, y))
    curve2.push((pre-x * x-scale, -y))
  }
  let fun-line = line.with(stroke: (thickness: 0.5pt, paint: red.darken(20%)))
  fun-line(..curve1)
  fun-line(..curve2)
  content((2 * x-scale, 1), anchor: "west")[#text(red.darken(20%))[$y = 1/x$]]
  content((2 * x-scale, -1), anchor: "west")[#text(red.darken(20%))[$y = -1/x$]]

  for n in range(1, N) {
    let x = n * x-scale
    let y = a(n)

    mark((x, -mark-radius), (x, mark-radius))
    point((x, y))
  }
})
