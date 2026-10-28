#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#let rotate-point(u, angle) = {
  let x = u.at(0)
  let y = u.at(1)
  let cos-a = calc.cos(angle)
  let sin-a = calc.sin(angle)

  let nx = x * cos-a - y * sin-a
  let ny = x * sin-a + y * cos-a
  return (nx, ny)
}

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let vector = line.with(stroke: 2pt + blue, mark: (end: "straight"))
  let rotated-vector = line.with(stroke: 2pt + red, mark: (end: "straight"))

  let x-min = 0
  let x-max = 4.3
  let y-min = 0
  let y-max = 3.5

  let u = (4, 0)
  let u-label = text(blue)[$chevron(4\, 0)$]
  let v = (calc.sqrt(3), 2)
  let v-label = text(blue)[$chevron(sqrt(3)\, 2)$]
  let rotation = 30deg
  let rotation-label = $30degree$
  let u-rotated = rotate-point(u, rotation)
  let u-rotated-label = text(red)[$chevron(2 sqrt(3)\, 2)$]
  let v-rotated = rotate-point(v, rotation)
  let v-rotated-label = text(red)[$chevron(1/2\, (3 sqrt(3))/2)$]

  axis((x-min, 0), (x-max, 0))
  axis((0, y-min), (0, y-max))
  grid((calc.ceil(x-min), calc.ceil(y-min)), (x-max, y-max), step: 1, stroke: 0.5pt + gray.transparentize(50%))

  vector((0, 0), u, name: "u")
  content(("u.start", 90%, "u.end"), anchor: "south", padding: 4pt, u-label)
  vector((0, 0), v, name: "v")
  content("v.end", anchor: "south", padding: 4pt, v-label)

  rotated-vector((0, 0), u-rotated, name: "u-rotated")
  content(("u-rotated.start", 90%, "u-rotated.end"), anchor: "north-west", padding: 4pt, u-rotated-label)
  rotated-vector((0, 0), v-rotated, name: "v-rotated")
  content("v-rotated.end", anchor: "south", padding: 4pt, v-rotated-label)

  let u-radius = 1
  let v-radius = 1
  arc(nt.mult(u-radius, nt.normalize(u)), start: calc.atan2(..u), delta: rotation, mark: (end: "straight"), radius: u-radius, name: "u-arc")
  content("u-arc.mid", anchor: "west", padding: 2pt, rotation-label)
  arc(nt.mult(v-radius, nt.normalize(v)), start: calc.atan2(..v), delta: rotation, mark: (end: "straight"), radius: v-radius, name: "v-arc")
  content("v-arc.mid", anchor: "south-west", padding: 2pt, rotation-label)
})

