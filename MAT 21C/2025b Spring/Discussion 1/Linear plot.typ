#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt)

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)

  let dx = 0.2
  let N = 30
  let x-bound = N * dx + 0.2
  let y-bound = 1.5

  axis((0, 0), (x-bound, 0))
  axis((0, 0), (0, y-bound))

  let a(n) = (n - 1) / n
  let mark = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let mark-radius = 0.05

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
  limit-line((-mark-radius, 1), (x-bound, 1))
  content((-mark-radius, 1), anchor: "east", padding: (right: 2pt))[#mi(`1`)]
})
