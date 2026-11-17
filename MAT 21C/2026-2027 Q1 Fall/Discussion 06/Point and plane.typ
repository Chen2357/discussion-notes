#import "@preview/cetz:0.5.2" as cetz: canvas
#import "../Packages/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)
#set math.accent(dotless: false)

#canvas(length: 2cm, {
  import cetz.draw: *
  let perspective-x = -80deg
  let perspective-y = 0deg
  let perspective-z = -10deg
  let perspective-normal = get-direction(perspective-x, perspective-y, perspective-z)

  perspective(x: perspective-x, y: perspective-y, z: perspective-z, {
    let base-point = (0, 0, 0)
    let half-side-1 = (1, 0, 0)
    let half-side-2 = (0, 1, 0)

    let normal = nt.normalize(cross(half-side-1, half-side-2))

    let test-point-1 = (3, 3, 1)
    let test-point-2 = (3.2, 0, 0)

    on-perspective(base-point, {
      circle((0, 0), radius: 2pt, stroke: none, fill: black)
    })

    on-layer(-3, {
      line(
        nt.add(base-point, nt.add(half-side-1, half-side-2)),
        nt.add(base-point, nt.sub(half-side-1, half-side-2)),
        nt.sub(base-point, nt.add(half-side-1, half-side-2)),
        nt.sub(base-point, nt.sub(half-side-1, half-side-2)),
        close: true,
      )
    })

    on-layer(-2, {
      line(
        base-point,
        nt.add(base-point, normal),
        stroke: 5pt + white,
      )
    })
    line(
      base-point,
      nt.add(base-point, normal),
      stroke: 1.5pt + red,
      mark: (end: (symbol: "straight")),
    )

    on-perspective(test-point-1, {
      circle((0, 0), radius: 2pt, stroke: none, fill: black)
    })

    on-layer(-2, {
      line(
        base-point,
        test-point-1,
        stroke: 5pt + white,
      )
    })
    line(
      base-point,
      test-point-1,
      stroke: 1.5pt + blue,
      mark: (end: (symbol: "straight")),
    )
    let test-point-1-projection = nt.sub(test-point-1, nt.add(base-point, nt.mult(nt.dot(test-point-1, normal), normal)))
    line(
      test-point-1,
      test-point-1-projection,
      stroke: (dash: "dashed", paint: gray),
    )
    line(
      base-point,
      test-point-1-projection,
      stroke: 1.5pt + blue.transparentize(80%),
      mark: (end: (symbol: "straight")),
    )

    on-perspective(test-point-2, {
      circle((0, 0), radius: 2pt, stroke: none, fill: black)
    })

    on-layer(-2, {
      line(
        base-point,
        test-point-2,
        stroke: 5pt + white,
      )
    })
    line(
      base-point,
      test-point-2,
      stroke: 1.5pt + purple,
      mark: (end: (symbol: "straight")),
    )
  })
})
