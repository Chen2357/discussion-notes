#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#let partial-sum(n) = {
  let p = 0
  let m = 1

  let sum = 0

  for k in range(0, n) {
    if sum <= 0 {
      sum += 1 / (2 * p + 1)
      p += 1
    } else {
      sum -= 1 / (2 * m)
      m += 1
    }
  }
  return sum
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)
  let connecting-line = line.with(stroke: 0.5pt + red)

  let dx = 0.15
  let N = 41
  let x-bound = N * dx + 0.1
  let y-bound = 1.2

  axis((0, 0), (x-bound, 0))
  axis((0, -y-bound / 4), (0, y-bound))

  let a(n) = partial-sum(n)
  let mark = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let mark-radius = 0.05
  let previous = none

  for n in range(1, N) {
    let x = n * dx
    let y = a(n)

    mark((x, -mark-radius), (x, mark-radius))
    content((x, -mark-radius), anchor: "north", padding: (top: 2pt))[#text(7pt)[$#n$]]

    if previous != none {
      connecting-line(previous, (x, y))
      previous = (x, y)
    } else {
      previous = (x, y)
    }

    point((x, y))
  }

  // let limit-line = line.with(stroke: (
  //   thickness: 1pt,
  //   paint: red.transparentize(50%),
  //   dash: "dashed",
  // ))
  // limit-line((-mark-radius, 1), (x-bound, 1))
  // content((-mark-radius, 1), anchor: "east", padding: (right: 2pt))[#mi(`1`)]
})
