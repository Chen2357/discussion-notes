#import "@preview/cetz:0.5.2" as cetz: canvas
#import "../Packages/lighting.typ": *
#import "../Packages/split-quad.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 7pt),
  fill: white.transparentize(100%),
)
#set math.accent(dotless: false)

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

#canvas(length: 0.8cm, {
  import cetz.draw: *
  perspective(x: -70deg, y: 0deg, z: -15deg, cull-face: "cw", {
    let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
    on-layer(-1, {
      axis((-6, 0, 0), (6, 0, 0))
      content((6.5, 0, 0))[#set text(20pt); $x$]
      axis((0, -8, 0), (0, 9, 0))
      content((0, 10.5, 0))[#set text(20pt); $y$]
      axis((0, 0, 0), (0, 0, 4.5))
      content((0, 0, 5.0))[#set text(20pt); $z$]
    })

    let x-space = nt.linspace(-5, 5, 40)
    let y-space = nt.linspace(-5, 5, 40)
    let z-values = x-space.map(x => y-space.map(y => f(x, y)))

    let test-x = -3.3
    let test-y = -3.0
    let test-z = f(test-x, test-y)

    let z-min = calc.min(..z-values.flatten())
    let z-max = calc.max(..z-values.flatten())
    let base-color-map = color.map.crest.rev()
    let z-color-step = (z-max - z-min) / (base-color-map.len() - 1)

    let color-map(z) = {
      let i = calc.floor((z - z-min) / z-color-step)
      return base-color-map.at(i)
    }

    for i in range(x-space.len() - 1) {
      for j in range(y-space.len() - 1) {
        let z00 = z-values.at(i).at(j)
        let z01 = z-values.at(i).at(j + 1)
        let z10 = z-values.at(i + 1).at(j)
        let z11 = z-values.at(i + 1).at(j + 1)
        let color = color-map((z00 + z01 + z10 + z11) / 4)
        let p00 = (
          x-space.at(i),
          y-space.at(j),
          z00,
        )
        let p01 = (
          x-space.at(i),
          y-space.at(j + 1),
          z01,
        )
        let p10 = (
          x-space.at(i + 1),
          y-space.at(j),
          z10,
        )
        let p11 = (
          x-space.at(i + 1),
          y-space.at(j + 1),
          z11,
        )
        let p10 = (
          x-space.at(i + 1),
          y-space.at(j),
          z10,
        )
        let p11 = (
          x-space.at(i + 1),
          y-space.at(j + 1),
          z11,
        )
        on-layer(0, {
          line(
            p00,
            p10,
            p11,
            p01,
            close: true,
            stroke: none,
            fill: color,
          )
        })
      }
    }

    on-layer(1, {
      on-perspective((test-x, test-y, test-z), {
        circle((0, 0), radius: 3pt, fill: red, stroke: none)
        content((0, 0), anchor: "south-east", padding: 5pt, [#set text(red, 24pt); $A$])
      })
      let z-values = x-space.map(x => f(x, test-y))
      line(
        ..x-space.zip(z-values).map(p => (p.at(0), test-y, p.at(1))),
        stroke: red + 1.5pt,
      )
    })
  })
})
