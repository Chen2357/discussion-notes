#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 1pt, fill: white.transparentize(100%))

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let a1 = 1
  let r = 0.83
  let N = 6

  let pos(x, y) = (x, 1.5 * y)
  let square(center, area, ..args) = {
    let (x, y) = center
    let width = calc.sqrt(area)
    let half = width / 2
    rect(
      (x - half, y - half),
      (x + half, y + half),
      stroke: 0.5pt + blue,
      ..args
    )
  }

  content(pos(-1, 0))[$s_#N$]
  content(pos(0, 0))[$=$]

  for i in range(1, N + 1) {
    if i != 1 {
      content(pos(2 * i - 2, 0))[$+$]
    }
    content(pos(2 * i - 1, 0))[$a_#i$]
    square(pos(2 * i - 1, 0), a1 * calc.pow(r, i - 1), name: "a" + str(i))
  }

  let arrow = line.with(stroke: 1pt, mark: (end: "straight"))

  arrow(pos(-1, -0.2), pos(-1, -0.8), name: "r")
  content("r.mid", anchor: "west", padding: (left: 3pt))[$times r$]

  content(pos(-1, -1))[$r s_#N$]
  content(pos(0, -1))[$=$]

  for i in range(1, N + 1) {
    if i != 1 {
      content(pos(2 * i, -1))[$+$]
    }
    if i == N {
      content(pos(2 * i + 1, -1))[$r a_#{i}$]
    } else {
      content(pos(2 * i + 1, -1))[$a_#{i + 1}$]
    }
    square(pos(2 * i + 1, -1), a1 * calc.pow(r, i), name: "ra" + str(i))

    hide(line(pos(2 * i - 1, 0), pos(2 * i + 1, -1), name: "hidden-line" + str(i)))
    intersections("i" + str(i), "a" + str(i), "hidden-line" + str(i), "ra" + str(i))
    hide(line("i" + str(i) + ".0", "i" + str(i) + ".1", name: "hidden-new-line" + str(i)))
    arrow((name: "hidden-new-line" + str(i), anchor: 10%), (name: "hidden-new-line" + str(i), anchor: 90%))
  }

  content(pos(-1, -2))[$s_#N - r s_#N$]
  content(pos(0, -2))[$=$]
  content(pos(1, -2))[$a_1$]
  square(pos(1, -2), a1)
  content(pos(2, -2))[$-$]
  content(pos(3, -2))[$r a_#N$]
  square(pos(3, -2), a1 * calc.pow(r, N))
})