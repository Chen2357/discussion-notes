#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.8pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 0.8cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let point = circle.with(radius: 2pt, fill: red, stroke: none)
  let function = line.with(stroke: 1pt + black)

  let xmax = 4
  let ymax = 3.5

  let x-space = nt.linspace(0.5, 3.5, 100)

  let f(x) = nt.add(nt.pow(nt.sub(x, 2), 2), 0.5)
  let g(x) = nt.sub(3.5, f(x))

  axis((0, 0), (xmax, 0))
  axis((0, 0), (0, ymax))

  function(..nt.transpose((x-space, f(x-space))))
  point((2, 0.5))
  content((xmax / 2, -0.8))[$f'' > 0$]
  content((xmax / 2, -1.4))[#set text(gray.darken(40%), 8pt); curving up]
  content((xmax / 2, -1.8))[#set text(gray.darken(40%), 8pt); "happy"]

  translate((xmax + 1, 0))

  axis((0, 0), (xmax, 0))
  axis((0, 0), (0, ymax))

  function(..nt.transpose((x-space, g(x-space))))
  point((2, 3))
  content((xmax / 2, -0.8))[$f'' < 0$]
  content((xmax / 2, -1.4))[#set text(gray.darken(40%), 8pt); curving down]
  content((xmax / 2, -1.8))[#set text(gray.darken(40%), 8pt); "sad"]
})
