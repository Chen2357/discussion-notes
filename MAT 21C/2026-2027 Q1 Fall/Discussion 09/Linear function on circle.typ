#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray.darken(20%), mark: (end: "straight"))

  let x-min = -1.5
  let x-max = 1.5
  let y-min = -1.5
  let y-max = 1.5

  axis((x-min, 0), (x-max, 0))
  content((x-max, 0), anchor: "west", padding: (bottom: 5pt, left: 2pt))[#text(14pt, gray.darken(20%), $x$)]
  axis((0, y-min), (0, y-max))
  content((0, y-max), anchor: "north-west", padding: (left: 4pt))[#text(14pt, gray.darken(20%), $y$)]

  let draw-line(point, slope, ..args) = {
    if float.is-infinite(slope) {
      let x = point.at(0)
      line((x, y-min), (x, y-max), stroke: blue + 1.5pt)
    } else {
      let intercept = point.at(1) - slope * point.at(0)

      let left = x-min
      let right = x-max
      let y-left = slope * left + intercept
      let y-right = slope * right + intercept

      if y-left < y-min {
        left = (y-min - intercept) / slope
        y-left = y-min
      } else if y-left > y-max {
        left = (y-max - intercept) / slope
        y-left = y-max
      }

      if y-right > y-max {
        right = (y-max - intercept) / slope
        y-right = y-max
      } else if y-right < y-min {
        right = (y-min - intercept) / slope
        y-right = y-min
      }

      line((left, y-left), (right, y-right), stroke: black + 1pt, ..args)
    }
  }

  let a = 12
  let b = 5
  let dv = 12 / 2
  let n = 4
  let fine = 6
  let values = nt.linspace(-dv * n, dv * n, 2 * n + 1)

  let fine-dv = dv / fine

  let slope = -a / b
  for i in range(array.len(values)) {
    let value = values.at(i)
    draw-line((0, value / b), slope)
    if value == 18 {
      content((rel: (0, -10pt)), frame: "rect", stroke: none, fill: white, padding: 2pt)[#set text(12pt); $#value$]
    }
    else {
      content((), frame: "rect", stroke: none, fill: white, padding: 2pt)[#set text(12pt); $#value$]
    }
    for j in range(1, fine) {
      let fine-value = value + j * fine-dv
      on-layer(-1, {
        draw-line((0, fine-value / b), slope, stroke: gray + 0.5pt)
      })
    }
  }

  circle((0, 0), radius: 1, stroke: red + 1.5pt)
})

