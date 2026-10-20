#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let flat(x) = {
    if x == 0 {
      return 0
    } else {
      return calc.exp(-1 / (x * x))
    }
  }
  let f(x) = (1 - flat(x)) * x
  let x-min = -3
  let x-max = 3
  let y-min = -1
  let y-max = 1
  let num-points = 500
  let points = nt.linspace(x-min, x-max, num-points).map(c => (c, f(c)))

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let fun-line = line.with(stroke: 2pt + red.darken(20%))
  let taylor-line = line.with(stroke: 2pt + blue.darken(20%))

  axis((x-min, 0), (x-max, 0))
  axis((0, y-min), (0, y-max))
  fun-line(..points)
  taylor-line((y-min, y-min), (y-max, y-max))
})
