#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#let make-title(title: "", author: "", date: datetime.today().display("[month repr:long] [day], [year]")) = {
  place(top + center, float: true)[
    #set align(center)

    #text(18pt, weight: "bold")[#title]

    #author

    #date
  ]
}
#set par(justify: true)

#let indigo = rgb(109, 107, 135)
#let red = rgb(199, 56, 52)
#let blue = rgb(15, 101, 160)
#let dark-magenta = rgb(104, 81, 120)

#let exercise(body) = showybox(
  frame: (
    border-color: indigo,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  body,
)

#let proof(body, label: "Proof") = {
  text(red, style: "italic")[#label.]
  body
}

#let remark(body, label: "Remark") = {
  show: it => block(inset: (left: 0.2in, right: 0.2in), it)
  set text(red)
  [#label:]
  body
}

#set heading(numbering: "§I")
#show heading: set block(below: 1em)

#make-title(
  title: "MAT 127A Discussion 1 Notes",
  author: "Chen Liang",
  date: "September 30, 2025",
)

= Warm-Up

#exercise[
  Suppose that $x in ZZ$.
  If $x^2 - 6x + 5$ is even, show that $x$ is odd.
]
#proof[
  Suppose for the sake of contradiction that $x$ is even, so $x = 2k$ for some $k in ZZ$.
  Then, $x^2 - 6x + 5$ would be odd because
  $
    x^2 & = (2 k)^2 = 4 k^2 = 2 (2 k^2) & "is even", \
    -6x & = -6 (2 k) = -12 k = 2 (-6 k) & "is even", \
      5 & = 2(2) + 1                    &  "is odd", \
  $
  and indeed
  $
    x^2 - 6x + 5 = 2 (2k^2 - 6k + 2) + 1 "is odd".
  $
  This contradicts the assumption, so $x$ must be odd.
]

= Proof by Contradiction

Here is a comparison between direct proof and proof by contradiction.

#table(
  columns: (1fr, 2fr, 3fr),
  table.header([], [If $A$, show $B$], [Show that an $x in X$ such that ... exists]),

  text(blue)[Direct proof],
  [
    #set par(leading: 0.4em, spacing: 1em)
    Since $A$,

    then....

    Thus, $B$.
  ],
  [
    #set par(leading: 0.4em, spacing: 1em)
    Let $x = ...$.

    We need to show that $x$ satisfies ....

    ...
  ],

  text(blue)[Proof by contradiction],
  [
    #set par(leading: 0.4em, spacing: 1em)
    Suppose for the sake of contradiction that $B$ is false,

    then....

    This is a contradiction, so $B$ must be true.
  ],
  [
    #set par(leading: 0.4em, spacing: 1em)
    Suppose for the sake of contradiction that all $x in X$ satisfies the negation of ...,

    then....

    This is a contradiction, so there exists an $x in X$ that satisfies ....
  ],

  table.cell(
    colspan: 3,
  )[
    #show: it => pad(it, top: 1em, bottom: 1em)
    #grid(
      columns: (1fr, 1fr),
      align: (center, left),
      {
        set align(horizon)
        canvas({
          import cetz.draw: *

          let r = 0.5
          let s = 0.3
          let N = 5

          for i in range(N) {
            circle(((2 * r + s) * i, 0), radius: r, fill: yellow, stroke: none)
            content(())[?]
          }
        })
      },
      [
        #text(dark-magenta)[*Does there exist a coin showing a tail?*]

        If we suppose all coins are showing heads\
        and arrive at a contradiction,

        then there must exist a coin showing a tail.
      ],
    )
  ],

  text(blue)[Proof by contrapositive],
  [
    #set par(leading: 0.4em, spacing: 1em)
    It suffices to prove the contrapositive that $B$ is false implies $A$ is false.

    Suppose $B$ is false,

    then....

    Thus, $A$ is false.
  ],
  [
    #set align(center + horizon)
    N/A
  ],
)

#remark(label: "Remark 1")[
  The proof that we used in the warm-up was branded as a proof by contradiction, but it can also be restated as a proof by contrapositive.
]

#remark(label: "Remark 2")[
  Other important proof techniques that we need to know include *proof by induction* and *proof by cases*.
]

= Injective and Surjective Functions

Recall that a function $f : A -> B$ is #text(dark-magenta)[injective] if
#align(center)[
  for all $x_1, x_2 in A$ such that $f(x_1) = f(x_2)$, we have $x_1 = x_2$.
]
#remark[
  To show that $f$ is *not injective* amounts to showing the existence of some $x_1, x_2 in A$ such that $f(x_1) = f(x_2)$, but we have $x_1 != x_2$.
  This characterization is useful to internalize because going from "$f$ is not injective" to this characterization requires a proof by contradiction/contrapositive.
  Internalizing it reduces this mental load.
]

A function $f : A -> B$ is #text(dark-magenta)[surjective] if
#align(center)[
  for all $y in B$, there exists an $x in A$ such that $f(x) = y$.
]

#exercise[
  #text(dark-magenta)[(Lecture 3)]
  Let $X = {x_1, x_2, ..., x_n}$.
  If $f : X -> X$ is surjective, show that it is injective.
]
#proof[
  It suffices to prove the contrapositive that if $f$ is not injective, then it is not surjective.
  Since $f$ is not injective, the subset ${f(x_1), f(x_2), ..., f(x_n)}$ has strictly fewer than $n$ elements.
  Therefore, there exists some element in $X$ that cannot be mapped to, so $f$ is not surjective.
]

A function is #text(dark-magenta)[bijective] if it is both injective and surjective.

#exercise[
  #set enum(numbering: "(a)")
  #text(dark-magenta)[(Exercise 1.2.8 modified)]
  Give an example of each.
  If we have time, try to write down a mathematical proof for each of them.
  + A function $f : NN -> NN$ that is surjective but not injective.
  + A function $f : NN -> NN$ that is injective but not surjective.
  + A function $f : ZZ -> NN$ that is bijective.
]
#proof(label: "Sample solution")[
  #set enum(numbering: "(a)")

  + $f(1) = 1$ and $f(x) = x-1$ for $x >= 2$.
    #align(center, {
      canvas({
        import cetz.draw: *

        let x = 1.5
        let s = 0.5
        let N = 5

        for i in range(N) {
          content((-x, -i * s))[$#{i+1}$]
          content((x, -i * s))[$#{i+1}$]

          line((-x + 0.2, -(i+1) * s), (x - 0.2, -i * s), mark: (end: "straight"))
        }
        content((-x, -N * s))[$dots.v$]
        content((x, -N * s))[$dots.v$]

        line((-x + 0.2, 0), (x - 0.2, 0), mark: (end: "straight"))
      })
    })
    - It is surjective because for all $y in NN$, we can let $x = y + 1$, then we have
    $
      f(x) = f(y + 1) = (y + 1) - 1 = y.
    $
    - It is not injective because $f(1) = 1$ and $f(2) = 1$ but $1 != 2$.


  + $f(x) = x + 1$.
    #align(center, {
      canvas({
        import cetz.draw: *

        let x = 1.5
        let s = 0.5
        let N = 5

        for i in range(N) {
          content((-x, -i * s))[$#{i+1}$]
          content((x, -i * s))[$#{i+1}$]

          line((-x + 0.2, -i * s), (x - 0.2, -(i + 1) * s), mark: (end: "straight"))
        }
        content((-x, -N * s))[$dots.v$]
        content((x, -N * s))[$dots.v$]
      })
    })
    - It is injective because $f(x_1) = f(x_2)$ means $x_1 + 1 = x_2 + 1$, which implies $x_1 = x_2$.
    - It is not surjective because there does not exist an $x in NN$ such that $f(x) = 1$ (_i.e._ $x + 1 = 1$).

  + $f(x) = 2x$ for $x >= 1$ and $f(x) = -2x + 1$ for $x <= 0$.
    #align(center, {
      canvas({
        import cetz.draw: *
        let f(x) = if x >= 1 { 2 * x } else { -2 * x + 1 }

        let x = 1.5
        let s = 0.5
        let N = 5

        for i in range(-N + 1, N) {
          content((-x, -i * s))[$#i$]
          content((x, -i * s))[$#f(i)$]
          line((-x + 0.4, -i * s), (x - 0.2, -i * s), mark: (end: "straight"))
        }
        content((-x, N * s))[$dots.v$]
        content((x, N * s))[$dots.v$]
        line((-x + 0.4, N * s), (x - 0.2, N * s), mark: (end: "straight"))

        content((-x, -N * s))[$dots.v$]
        content((x, -N * s))[$dots.v$]
        line((-x + 0.4, -N * s), (x - 0.2, -N * s), mark: (end: "straight"))

        cetz.decorations.brace((x + 0.2, N * s + 0.2), (x + 0.2, -0.1), name: "odd-brace")
        content("odd-brace.spike", anchor: "west", padding: 3pt)[Odd natural numbers]

        cetz.decorations.brace((x + 0.2, -s + 0.1), (x + 0.2, -N * s - 0.2), name: "even-brace")
        content("even-brace.spike", anchor: "west", padding: 3pt)[Even natural numbers]
      })
    })
    - It is injective because if $f(x_1) = f(x_2)$, then we have the following cases:
      - If both $x_1, x_2 > 0$, then $2x_1 = 2x_2$ implies $x_1 = x_2$.
      - If both $x_1, x_2 <= 0$, then $-2x_1 - 1 = -2x_2 + 1$ implies $x_1 = x_2$.
      - The case $x_1 > 0$ and $x_2 <= 0$ cannot happen because $f(x_1) = 2x_1$ is even while $f(x_2) = -2x_2 + 1$ is odd.
      - Similarly, the case $x_1 < 0$ and $x_2 >= 0$ cannot happen.
      In all possible cases, we have $x_1 = x_2$, so $f$ is injective.
    - It is surjective because for all $y in NN$, we have the following cases:
      - If $y in NN$ is even, then let $x = y / 2$. Since $x > 0$ (because $y > 0$), we have
        $
          f(x) = 2x = 2 (y / 2) = y.
        $
      - If $y in NN$ is odd, then let $x = -(y - 1) / 2$. Since $x <= 0$ (because $y - 1 >= 0$), we have
        $
          f(x) = -2x + 1 = -2 (-(y - 1) / 2) + 1 = y.
        $
      Therefore, we can always find an $x in ZZ$ such that $f(x) = y$, so $f$ is surjective.
]
