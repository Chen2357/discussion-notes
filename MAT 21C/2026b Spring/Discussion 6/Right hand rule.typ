#import "@preview/cetz:0.5.0" as cetz: canvas
#import "../Template/lighting.typ": *
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
  ortho(x: -70deg, y: 0deg, z: -120deg, {
    let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
    // axis((0, 0, 0), (2, 0, 0))
    // content((2.2, 0, 0))[$x$]
    // axis((0, 0, 0), (0, 2, 0))
    // content((0, 2.2, 0))[$y$]
    // axis((0, 0, 0), (0, 0, 2))
    // content((0, 0, 2.2))[$z$]

    let view = get-direction(-70deg, 0deg, -120deg)

    let h = 1
    let r = 2
    let N = 120
    for theta in nt.linspace(0, 2 * calc.pi, N + 1) {
      let x = r * nt.cos(theta)
      let y = r * nt.sin(theta)
      if nt.dot(view, (x, y, 0)) < 0 {
        continue
      }

      let next-x = r * nt.cos(theta + 2 * calc.pi / N)
      let next-y = r * nt.sin(theta + 2 * calc.pi / N)
      
      let intensity = calculate-lighting((x, y, 0))
      line(
        (x, y, -h),
        (next-x, next-y, -h),
        (next-x, next-y, 0),
        (x, y, 0),
        close: true,
        stroke: none,
        fill: shade-color(gray, intensity)
      )
    }
    let top-intensity = calculate-lighting((0, 0, 1))
    line(
      ..nt.linspace(0, 2 * calc.pi, N + 1).map(theta => (r * nt.cos(theta), r * nt.sin(theta), 0)),
      close: true,
      stroke: none,
      fill: shade-color(gray.darken(30%), top-intensity)
    )

    let a = (1.8, 0, 0)
    let b = (0, 1.8, 0)
    let vector(..args, stroke: 2pt + blue, mark-stroke: none) = line(stroke: stroke, mark: (end: (symbol: "straight", stroke: if mark-stroke == none { stroke } else { mark-stroke })), ..args)

    on-layer(1, {
      vector((0, 0, 0), a, stroke: 2pt + red, name: "a")
      content("a.mid", angle: (-1.8, 2, 0), anchor: "south", padding: 5pt, [#set text(red); $arrow(a)$])
      let blue = blue.darken(30%)
      vector((0, 0, 0), b, stroke: (thickness: 2pt, dash: "dashed", paint: blue), mark-stroke: 2pt + blue, name: "b")
      content("b.mid", angle: (-2, 1.8, 0), anchor: "south", padding: 5pt, [#set text(blue); $arrow(b)$])
    })
  })
})

