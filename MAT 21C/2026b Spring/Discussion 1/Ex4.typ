#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt)
#import "@preview/numty:0.1.0" as nt

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)

  let x-scale = 0.2
  let y-scale = 0.2
  let N = 15
  let x-bound = N * x-scale + 0.2
  let y-min = -N * y-scale
  let y-max = 2 * y-scale

  axis((0, 0), (x-bound, 0))
  axis((0, y-min), (0, y-max))

  let a(n) = if calc.rem(n, 2) == 0 { -n } else { 0 }
  let mark = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let mark-radius = 0.05

  for n in range(1, N) {
    let x = n * x-scale
    let y = a(n) * y-scale

    mark((x, -mark-radius), (x, mark-radius))
    point((x, y))
  }
})
