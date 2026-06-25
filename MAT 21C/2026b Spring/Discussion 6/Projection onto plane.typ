#import "@preview/cetz:0.5.0" as cetz: canvas
#import "../Template/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.8pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 1cm, {
  import cetz.draw: *
  import cetz.decorations: *

  let x = calc.sqrt(35)
  let y = calc.sqrt(6)
  let d = 5 / calc.sqrt(6)
  let l = -1
  let r = 6.5

  let vector(stroke: 1pt, ..args) = line(stroke: stroke, mark: (end: (symbol: "straight", stroke: stroke)), ..args)
  vector((0, 0), (0, y))
  content((0, y), anchor: "north-east", padding: (right: 2pt), [$chevron.l 2, 1, -1 chevron.r$])
  line((l, 0), (r, 0), stroke: 2pt + red)

  vector((0, 0), (x, y), stroke: 1pt + blue, name: "u")
  content(("u.start", 50%, "u.end"), angle: "u.end", anchor: "south", padding: 3pt, [#set text(blue); $chevron.l 3, 4, 4 chevron.r$])
  vector((0, 0), (x, 0), stroke: 2pt + blue.darken(30%))
  content((x * 0.5, 0), anchor: "south", padding: (bottom: 4pt, right: 4pt), [#set text(blue.darken(30%)); $hat(v)$])

  let aux = line.with(stroke: (thickness: 1pt, paint: gray, dash: "dashed"))
  aux((x, 0), (x, y))
  aux((0, y), (x, y))


  
  // brace((0, d), (0, 0), name: "b")
  // content("b.spike", anchor: "west", padding: (left: 2pt), [$5/sqrt(6)$])
})
  
