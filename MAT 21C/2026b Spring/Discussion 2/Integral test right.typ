#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#import "@preview/modpattern:0.1.0": modpattern
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#let hatched(size: (.2cm, .2cm), ..args) = modpattern(size, {
  std.line(start: (0%, 100%), end: (100%, 0%), ..args)
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))

  axis((0, 0), (6.4, 0))
  content((6.4, 0), anchor: "west", padding: (left: 2pt))[$x$]
  axis((0, 0), (0, 4))
  content((0, 4), anchor: "south", padding: (bottom: 2pt))[$y$]
  content((0.2, 0), anchor: "center")[#text(gray)[\/\/]]

  let tick = line.with(stroke: (thickness: 0.5pt, paint: gray))
  let tick-radius = 0.1

  let f(n) = 27 / (1 + calc.pow(n, 2))
  let N = 4
  let x-start = 1.5
  let dx = 0.6

  let fun-num = 100
  let term-num = 7

  let right-rect(i) = {
    let x = x-start + i * dx
    rect(
      (x, 0), (x + dx, f(N + i)),
      stroke: none,
      fill: blue.darken(20%),
    )
    if i == 0 {
      content((x + dx / 2, f(N + i)), anchor: "south", padding: (bottom: 2pt))[#text(7pt)[$a_N$]]
    } else {
      content((x + dx / 2, f(N + i)), anchor: "south", padding: (bottom: 2pt))[#text(5pt)[$a_(N + #i)$]]
    }
  }

  for i in range(term-num) {
    let n = N + i
    let x = x-start + i * dx
    let y = f(n)
    tick((x, -tick-radius), (x, tick-radius))
    if i == 0 {
      content((x, -tick-radius), anchor: "north", padding: (top: 2pt))[#text(5pt)[$N$]]
    } else {
      content((x, -tick-radius), anchor: "north", padding: (top: 2pt))[#text(5pt)[$N + #i$]]
    }

    right-rect(i)
    circle((x, y), radius: 1.5pt, fill: red, stroke: none)
  }

  content((x-start + (term-num + 0.4) * dx, f(N + term-num - 1) / 2), anchor: "center")[#text(blue.darken(20%))[$dots.c$]]

  let fun-points = nt.linspace(N , N + term-num + 0.8, fun-num).map(n => (x-start + (n - N) * dx, f(n)))
  let draw-fun = line.with(stroke: (thickness: 0.5pt, paint: red.darken(20%)))
  draw-fun(..fun-points)
  on-layer(1, {
    line(
      (x-start, 0),
      (x-start, f(N - 1)),
      ..nt.linspace(N, N + term-num, fun-num).map(n => (x-start + (n - N) * dx, f(n))),
      (x-start + term-num * dx, f(N + term-num)),
      (x-start + term-num * dx, 0),
      close: true,
      stroke: none,
      fill: hatched(size: (.1cm, .1cm), stroke: red + 0.4pt),
      pattern: "north-east-lines",
    )
  })

  content((3, 3))[
    $display(integral_N^oo f(x) space.thin d x <= sum_(n = N)^(oo) a_n)$
  ]
})
