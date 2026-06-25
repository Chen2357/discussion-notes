#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 5cm, {
  import cetz.draw: *

  let ground = line.with(stroke: 0.2pt)

  let square(a, b) = {
    let width = (b - a) / 3
    let x = a + (b - a) / 3
    line(
      (x, 0), (x, width), (x + width, width), (x + width, 0), (x, 0),
      close: true,
      stroke: none,
      fill: blue.darken(20%),
    )
  }

  let recursion(a, b, n) = {
    if n == 0 {
      return
    }
    square(a, b)
    recursion(a, a + (b - a) / 3, n - 1)
    recursion(a + 2 * (b - a) / 3, b, n - 1)
  }

  let label(n) = content((0.03, 0.3), anchor: "north-west")[Step #n]

  let x-step = 1.2
  let y-step = -0.5

  ground((0, 0), (1, 0))
  recursion(0, 1, 1)
  label(1)

  translate(x: x-step)

  ground((0, 0), (1, 0))
  recursion(0, 1, 2)
  label(2)

  translate(x: -x-step, y: y-step)

  ground((0, 0), (1, 0))
  recursion(0, 1, 3)
  label(3)

  translate(x: x-step)

  ground((0, 0), (1, 0))
  recursion(0, 1, 4)
  label(4)
})
