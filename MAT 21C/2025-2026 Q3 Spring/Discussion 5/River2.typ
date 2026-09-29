#import "@preview/cetz:0.4.2" as cetz
#import "@preview/mitex:0.2.6": mi, mitex
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  
  let river = line.with(stroke: 1pt + blue)
  let location = circle.with(radius: 2pt, fill: red, stroke: none)
  let a = (-0.2, 1)
  let b = (2.2, 1.5)

  river((-1, 0), (3, 0))
  location(a)
  content((), anchor: "east", padding: (right: 5pt))[$A$]
  location(b)
  content((), anchor: "west", padding: (left: 5pt))[$B$]

  let path(x, ..args) = {
    on-layer(-1, {
      line(a, (x, 0), ..args)
      line((x, 0), b, ..args)
    })
  }

  path(1.5, stroke: (thickness: 0.7pt, paint: gray))

  location((a.at(0), -a.at(1)))
  content((), anchor: "east", padding: (right: 5pt))[$A'$]

  let path2(x, ..args) = {
    on-layer(-2, {
      line((a.at(0), -a.at(1)), (x, 0), ..args)
      line((x, 0), b, ..args)
    })
  }

  path2(1.5, stroke: (thickness: 1.6pt, paint: yellow))

  let optimal-x = a.at(0) + a.at(1) * (b.at(0) - a.at(0)) / (a.at(1) + b.at(1)) 
  path(optimal-x, stroke: (thickness: 1.6pt, paint: red))
  path2(optimal-x, stroke: (thickness: 1.6pt, paint: red))
})
