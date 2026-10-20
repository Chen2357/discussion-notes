#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let river = line.with(stroke: 1pt + blue)
  let location = circle.with(radius: 2pt, fill: red, stroke: none)
  let a = (-0.2, 1)
  let b = (2.2, 1.5)

  river((-1, 0), (3, 0))
  content((), anchor: "south-east", padding: (bottom: 3pt))[#text(blue, 7pt)["River"]]
  location(a)
  content((), anchor: "north-east", padding: (right: 5pt))[#text(7pt)["Town 1"]]
  location(b)
  content((), anchor: "north-west", padding: (left: 5pt))[#text(7pt)["Town 2"]]

  let path(x, ..args) = {
    on-layer(-1, {
      line(a, (x, 0), ..args)
      line((x, 0), b, ..args)
    })
  }

  let optimal-x = a.at(0) + a.at(1) * (b.at(0) - a.at(0)) / (a.at(1) + b.at(1))
  path(optimal-x, stroke: (thickness: 1pt, paint: black))
  on-layer(-1, {
    line(a, (rel: (-0.3, 0.2)))
    content((), anchor: "east", padding: (right: 2pt))[#std.scale(x: -100%)[🤏]]
    line(b, (rel: (0.3, 0.2)))
    content((), anchor: "west", padding: (left: 2pt))[#std.scale(x: 100%)[🤏]]
  })

  location((optimal-x, 0))

  let force-magnitude = 0.6
  let force(v, ..args) = line(
    (optimal-x, 0),
    (rel: nt.mult(nt.normalize(v), force-magnitude)),
    stroke: (thickness: 1.2pt, paint: red),
    mark: (end: "stealth"),
    fill: red,
    ..args,
  )
  force(nt.sub(a, (optimal-x, 0)), name: "a")
  force(nt.sub(b, (optimal-x, 0)), name: "b")

  let aux-line(..args) = line(stroke: (thickness: 0.7pt, paint: red, dash: "dashed"), ..args)
  aux-line("a.end", (rel: nt.mult(nt.normalize(nt.sub(b, (optimal-x, 0))), force-magnitude)))
  aux-line("b.end", (rel: nt.mult(nt.normalize(nt.sub(a, (optimal-x, 0))), force-magnitude)), name: "aux")

  line((optimal-x, 0), "aux.end", stroke: (thickness: 1.2pt, paint: red), mark: (end: "stealth"), fill: red)
  let arc-radius = 0.25
  let angle = calc.atan((b.at(1) + a.at(1)) / (b.at(0) - a.at(0)))
  on-layer(-2, {
    arc((optimal-x + arc-radius, 0), start: 0deg, delta: angle, radius: arc-radius, stroke: (paint: red))
    arc((optimal-x - arc-radius, 0), start: 180deg, delta: -angle, radius: arc-radius, stroke: (paint: red))
  })
})

