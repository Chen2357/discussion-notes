#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#import "Trail shared.typ": *
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.8pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 0.8cm, {
  import cetz.draw: *

  let r = 5
  for row in data {
    let points = row.chunks(2).filter(p => -r <= p.at(0) and p.at(0) <= r and -r <= p.at(1) and p.at(1) <= r)
    if points.len() < 2 { continue }
    line(..points, stroke: gray + 1.5pt)
  }

  for label in labels {
    content(label.point, frame: "rect", padding: 1pt, stroke: none, fill: white, [#label.height])
  }

  hobby(
    ..key-frames,
    stroke: red + 1.5pt,
  )

  circle(key-frames.at(0), radius: 4pt, fill: red, stroke: none)
  content(nt.add(key-frames.at(0), (0, 0.3)), anchor: "south", padding: (top: 2pt, left: 2pt, right: 2pt, bottom: 5.5pt), frame: "rect", stroke: none, fill: red.lighten(50%))[#set text(15pt); 8am start]

  circle(key-frames.at(lunch-index), radius: 4pt, fill: red, stroke: none)
  content(nt.add(key-frames.at(lunch-index), (0.3, 0)), anchor: "north-west", padding: 2pt, frame: "rect", stroke: none, fill: red.lighten(50%))[#set text(15pt); 12pm lunch]

  circle(key-frames.at(key-frames.len()-1), radius: 4pt, fill: red, stroke: none)
  content(nt.add(key-frames.at(key-frames.len()-1), (0, -0.3)), anchor: "north", padding: 2pt, frame: "rect", stroke: none, fill: red.lighten(50%))[#set text(15pt); 6pm end]
})


