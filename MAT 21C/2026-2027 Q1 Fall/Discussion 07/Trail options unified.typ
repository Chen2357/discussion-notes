#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#import "Trail shared.typ": *
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 7pt),
  fill: white.transparentize(100%),
)

#let common() = {
  import cetz.draw: *

  transform((
    (0.7, 0, 0, 0),
    (0, 0.7, 0, 0),
    (0, 0, 1, 0),
    (0, 0, 0, 1),
  ))
  line((8, 0), (18, 0))

  for i in range(1, 7) {
    line((8, i), (18, i), stroke: (dash: "dashed", paint: gray))
    content((8, i), anchor: "east", padding: (right: 4pt))[#set text(10pt); #{ i * 40 }]
  }

  let tick-radius = 0.1
  line((8, -tick-radius), (8, tick-radius))
  content((8, -tick-radius), anchor: "north", padding: 2pt)[#set text(10pt); 8am]
  line((12, -tick-radius), (12, tick-radius))
  content((12, -tick-radius), anchor: "north", padding: 2pt)[#set text(10pt); 12pm]
  line((18, -tick-radius), (18, tick-radius))
  content((18, -tick-radius), anchor: "north", padding: 2pt)[#set text(10pt); 6pm]
}

#let incorrect-key-frames-1 = (
  (8, key-frame-values.at(0)),
  (9, key-frame-values.at(1) + 15),
  (10, key-frame-values.at(2) + 68),
  (11, key-frame-values.at(3) + 60),
  (12, key-frame-values.at(4)),
  (13, key-frame-values.at(5) - 40),
  (13.5, key-frame-values.at(6) - 50),
  (14, key-frame-values.at(7) - 50),
  (15, key-frame-values.at(8) - 40),
  (16, key-frame-values.at(9) - 8),
  (17, key-frame-values.at(10) - 5),
  (18, key-frame-values.at(11)),
)

#let incorrect-key-frames-2 = (
  (8, key-frame-values.at(0)),
  (9, key-frame-values.at(1)),
  (10, key-frame-values.at(2)),
  (11, key-frame-values.at(3)),
  (12, key-frame-values.at(4)),
  (13, key-frame-values.at(5) - 10),
  (13.5, key-frame-values.at(6) - 10),
  (14, key-frame-values.at(7)),
  (15, key-frame-values.at(8) + 20),
  (16, key-frame-values.at(9) + 50),
  (17, key-frame-values.at(10) + 30),
  (18, key-frame-values.at(11)),
)

#grid(
  columns: 3,
  align: center,
  row-gutter: 0.6em,
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    common()
    let points = ()
    for i in range(0, incorrect-key-frames-1.len()) {
      let time = incorrect-key-frames-1.at(i).at(0)
      let value = incorrect-key-frames-1.at(i).at(1) / 40 + 1

      points.push((time, value))
    }

    hobby(..points, stroke: red + 1.5pt)
  }),
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    common()
    let points = ()
    for i in range(0, key-frames-with-time.len()) {
      let time = key-frames-with-time.at(i).at(0)
      let value = key-frame-values.at(i) / 40 + 1

      points.push((time, value))
    }

    hobby(..points, stroke: red + 1.5pt)
  }),
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    common()
    let points = ()
    for i in range(0, incorrect-key-frames-2.len()) {
      let time = incorrect-key-frames-2.at(i).at(0)
      let value = incorrect-key-frames-2.at(i).at(1) / 40 + 1

      points.push((time, value))
    }

    hobby(..points, stroke: red + 1.5pt)
  }),

  [#set text(15pt); Option (A)], [#set text(15pt); Option (B)], [#set text(15pt); Option (C)],
)
