#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)

#let f(x, y) = {
  let x_r = x - 1.0
  let y_r = y - 0.5
  let hill_right = 2.0 * calc.exp(-(0.12 * x_r * x_r - 0.08 * x_r * y_r + 0.18 * y_r * y_r))

  let x_l = x + 1.5
  let y_l = y + 1.0
  let hill_left = 1.2 * calc.exp(-(0.15 * x_l * x_l + 0.06 * x_l * y_l + 0.10 * y_l * y_l))

  let x_phantom = x + 6.0
  let y_phantom = y - 6.0
  let hill_phantom = 3.0 * calc.exp(-(0.10 * x_phantom * x_phantom + 0.10 * y_phantom * y_phantom))

  let background_slope = 0.15 * x + 0.05 * y

  return hill_right + hill_left + hill_phantom + background_slope
}

#let test-x = -4.2
#let test-y = -3.2

#let modified_f(x, y) = {
  return (f(x, y) - f(test-x, test-y)) / 0.78 + 62 / 40
}

#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let tick = line.with(stroke: 1pt + gray)
  let tick-radius = 0.1
  axis((-5, 0), (5, 0))
  content((5, 0), anchor: "west", padding: 2pt, [#set text(18pt); $x$])
  axis((0, -0), (0, 5))
  content((0, 5), anchor: "south", padding: 2pt, [#set text(18pt); $z$])

  for i in range(-4, 5) {
    tick((i, -tick-radius), (i, tick-radius))
  }

  for i in range(1, 5) {
    tick((-tick-radius, i), (tick-radius, i))
    content((tick-radius, i), anchor: "west", padding: 2pt, [#set text(14pt); $#{ i * 40 }$])
  }

  let x = nt.linspace(-5, 5, 40)
  let z = x.map(x_i => modified_f(x_i, test-y))

  line(
    ..x.zip(z),
    stroke: 2pt + red,
  )
  content((test-x, modified_f(test-x, test-y)), anchor: "north-west", padding: 2pt, [#set text(24pt, red); $A$])
  circle((test-x, modified_f(test-x, test-y)), radius: 4pt, fill: red, stroke: none)
})
