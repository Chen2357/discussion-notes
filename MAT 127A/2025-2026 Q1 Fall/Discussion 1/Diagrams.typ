#import "@preview/cetz:0.4.2"

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#set page(width: auto, height: auto, margin: 0.5pt)
#show: doc => context {
  place(hide(doc))
  query(<something>).map(x => x.value).intersperse(pagebreak(weak: true)).join()
}

#include "Discussion 1.typ"

#align(center, {
  canvas({
    import cetz.draw: *
    let f(x) = if x >= 1 { 2 * x } else { -2 * x + 1 }

    let x = 1.5
    let s = 0.5
    let N = 5

    for i in range(-N + 1, N) {
      content((x, -i * s))[$#i$]
      content((-x, -i * s))[$#f(i)$]
      line((-x + 0.2, -i * s), (x - 0.4, -i * s), mark: (end: "straight"))
    }
    content((-x, N * s))[$dots.v$]
    content((x, N * s))[$dots.v$]
    line((-x + 0.2, N * s), (x - 0.4, N * s), mark: (end: "straight"))

    content((-x, -N * s))[$dots.v$]
    content((x, -N * s))[$dots.v$]
    line((-x + 0.2, -N * s), (x - 0.4, -N * s), mark: (end: "straight"))

    cetz.decorations.brace((-x - 0.2, -0.1), (-x - 0.2, N * s + 0.2), name: "odd-brace")
    content("odd-brace.spike", anchor: "east", padding: 3pt)[Odd natural numbers]

    cetz.decorations.brace((-x - 0.2, -N * s - 0.2), (-x - 0.2, -s + 0.1), name: "even-brace")
    content("even-brace.spike", anchor: "east", padding: 3pt)[Even natural numbers]
  })
})
