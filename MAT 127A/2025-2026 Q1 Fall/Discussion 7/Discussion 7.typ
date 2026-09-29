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

#let define(body) = text(body, dark-magenta)

#let exercise(body) = showybox(
  frame: (
    border-color: indigo,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  body,
)

#let proof(body, qed: $qed$, label: "Proof") = {
  text(red, style: "italic")[#label.]
  body
  if qed != none {
    h(1fr)
    qed
  }
}

#let remark(body, label: "Remark") = {
  show: it => block(inset: (left: 0.2in, right: 0.2in), it)
  set text(red)
  [#label:]
  body
}

#set heading(numbering: "§I")
#show heading: set block(below: 1em)

#let subset = symbol(
  "⊆",
  ("p", "⊈"),
)
#let supset = symbol(
  "⊇",
  ("p", "⊉"),
)

#let note(body) = box(text(body, font: "PT Mono"), fill: yellow.lighten(75%), inset: 3pt, baseline: 3pt, radius: 5pt)
#let my-box(body) = box(body, stroke: 1pt, inset: 3pt, baseline: 3pt)

#make-title(
  title: "MAT 127A Discussion 7 Notes",
  author: "Chen Liang",
  date: "November 11, 2025 (Veterans Day)",
)

= Review Checklist

Go over the checklist and rate your understanding of each definition/theorem from
- 1 : I don't remember this at all.
- 5 : I can prove the theorem or state the definition with the same level of detail as in the textbook.
This checklist only includes items from lectures,  do not forget to go over homework solutions as well!

Some items have parentheses after them indicating their Definition/Theorem number in the textbook.
I recommend you to look at the textbook as opposed to lecture notes whenever possible, since the textbook is held to a higher standard of mathematical writing.

#set table(
  stroke: none,
  gutter: 0.1em,
  fill: gray.lighten(70%)
  // fill: (x, y) => if x == 0 or y == 0 { gray }
)

#let f(items) = items.map(x => (x, [], [], [], [], [])).flatten()

// #show table.cell.where(x: 0): strong
// #show table.cell.where(y: 0): strong

#table(
  columns: (1fr, 20pt, 20pt, 20pt, 20pt, 20pt),
  table.header(
    table.cell(align: center)[],
    table.cell(align: center)[1],
    table.cell(align: center)[2],
    table.cell(align: center)[3],
    table.cell(align: center)[4],
    table.cell(align: center)[5],
  ),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.17.25]],
  ..f((
    [Definition of sequence (2.2.1)],
    [Definition of limit (2.2.3 also discussion 4)],
    [Definition of neighborhood (2.2.4)],
    [It is not true that $lim (-1)^n = 0$],
    [$lim 1/sqrt(n) = 0$ (2.2.5)],
    [$lim (sin n)/(sqrt(n)) = 0$],
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.20.25]],
  ..f((
    [Definition of bounded sequence (2.3.1)],
    [$((-1)^n)$ is bounded],
    [Convergent implies bounded (2.3.2)],
    [Algebraic limit theorem (2.3.3 also discussion 4)],
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.22.25]],
  ..f((
    [Order limit theorem (2.3.4)],
    [Definition of monotone sequence (2.4.1)],
    [Monotone convergence theorem (2.4.2)]
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.24.25]],
  ..f((
    [Definition of subsequence (2.5.1)],
    [Subsequences of a convergent sequence share limit (2.5.2)],
    [Bolzano-Weierstrass theorem (2.5.5)],
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.27.25]],
  ..f((
    [Definition of Cauchy sequence (2.6.1 also discussion 5)],
    [Convergence implies Cauchy (2.6.2)],
    [Cauchy implies bounded (2.6.3)],
    [Cauchy criterion (2.6.4 also discussion 5)],
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.29.25]],
  ..f((
    [Definition of $limsup$ and $liminf$ (exercise 2.4.7)],
    [Definition of oscillation of a sequence],
    [Bounded implies $limsup$ and $liminf$ exist],
    [Squeeze theorem (exercise 2.3.3)],
    [$limsup a_n = liminf a_n = a$ if and only if $lim a_n = a$]
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 10.31.25]],
  ..f((
    [Definition of open set (3.2.1 also discussion 6)],
    [$(0, 1]$ is not open],
    [$(0, 1)$ is open (3.2.2 also discussion 6)],
    [Arbitrary union and finite intersection of open sets is open (3.2.3)],
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 11.03.25]],
  ..f((
    [Definition of limit point (3.2.4 also discussion 6)],
    [$[0, 1]$ is the set of limit points of $(0, 1)$],
    [$[0, 1]$ is the set of limit points of $(0, 1) union {2}$],
    [Definition of isolated point (3.2.6)],
    [Definition of closed set (3.2.7 also discussion 6)],
    [Sequential characterization of limit points (3.2.5)],
    [$[0, 1]$ is closed (3.2.9)],
    [${1/n | n in NN} union {0}$ is closed (3.2.9)],
    [Definition of closure (3.2.11)],
    [Alternative characterization of closure (3.2.12)]
  )),
  table.cell(colspan: 6, fill: none, align: center, inset: 2pt)[#text(size: 8pt)[Lecture 11.05.25]],
  ..f((
    [Complement of open set is closed and vice versa (3.2.13 also discussion 6)],
    [Arbitrary intersection and finite union of closed sets is closed (3.2.14)],
    [Definition of compact set (3.3.1)],
    [$RR$ is not compact],
    [$[0, 1)$ is not compact],
    [Compact if and only if closed and bounded (3.3.4)]
  ))
)

= Compactness is "Topological Finiteness"

When we have a property about finite sets, the topological version of that property will often hold for compact sets.
This is the key insight behind the open cover characterization of compactness:
#align(center)[
  #block(width: 80%)[
    a set $K subset RR$ is compact if and only if every open cover of $K$ has a finite subcover.
  ]
]

For example, for every finite list of real numbers $(x_1, x_2, ..., x_n)$, if we know that if we have $x_(k) = x_(k+1) = 0$ for all $1 <= k < n$, then we can conclude that $x_1 = x_n$.
A topological version of this property might be that for every differential function $f : RR -> RR$ such that $f'(x) = 0$ for all $x in [0, 1]$, we can conclude that $f(0) = f(1)$.
This is a key ingredient in the proof of the fundamental theorem of calculus.

We have not learned derivatives yet, but we can still appreciate compactness by another topological version of the same property:
#align(center)[
  #block(width: 80%)[
    for every function $f : RR -> RR$ such that for every $x in [0, 1]$, there exists a $delta > 0$ such that $f$ is constant on $(x - delta, x + delta)$, then we have $f(0) = f(1)$.
  ]
]
#proof[
  Consider the set of $V_(delta\/2) (x)$ such that $f$ is constant on $V_(delta) (x)$ where $x in [0, 1]$ and $delta > 0$.
  By the assumption of the theorem, these $V_(delta\/2) (x)$ form an open cover of $[0, 1]$.
  Since $[0, 1]$ is compact, there exists a finite subcover ${V_(delta_1\/2) (x_1), ..., V_(delta_n\/2) (x_n)}$ such that $f$ is constant on each $V_(delta_k) (x_k)$ for $1 <= k <= n$.

  Let $delta = min {delta_1/2, ..., delta_n/2}$.
  We claim that if $|x - y| <= delta$ for some $x, y in [0, 1]$, then $f(x) = f(y)$.
  Since $x$ is in some $V_(delta_k/2) (x_k)$, we have
  $
    |y - x_k| <= |y - x| + |x - x_k| < delta + delta_k/2 <= delta_k/2 + delta_k/2 = delta_k.
  $
  Therefore, we have $x, y in V_(delta_k) (x_k)$, and so indeed $f(x) = f(y)$.

  Consider a natural number $N$ such that $1/N < delta$.
  Then by the above claim, we have $f(k/N) = f((k+1)/N)$ for all $0 <= k < N$.
  Therefore as in the finite case, we can conclude that $f(0) = f(0/N) = f(N/N) = f(1)$.
]

In the above proof, compactness allowed us reduce the theorem into the finite version of theorem which we can easily prove.
This is the general strategy of using compactness to prove topological theorems.
Use this strategy to do the following exercise.

#exercise[
  Show that if $f : RR -> RR$ is locally increasing (i.e., for every $x in RR$, there exists $delta > 0$ such that for all $y, z in V_(delta) (x)$ with $y < z$, we have $f(y) <= f(z)$), then $f$ is increasing.
]
#proof[
  To prove that $f$ is increasing, let $a, b in RR$ with $a < b$, then we want to show that $f(a) <= f(b)$.
  Consider the set of $V_(delta\/2) (x)$ such that $f$ is increasing on $V_(delta) (x)$.
  These $V_(delta\/2) (x)$ form an open cover of $[a, b]$.
  Since $[a, b]$ is compact, there exists a finite subcover ${V_(delta_1\/2) (x_1), ..., V_(delta_n\/2) (x_n)}$ that covers $[a, b]$.

  Let $delta = min {delta_1/2, ..., delta_n/2}$.
  We claim that if $|x - y| <= delta$ for some $x, y in [a, b]$, then $f(x) <= f(y)$.
  Since $x$ is in some $V_(delta_k/2) (x_k)$, we have
  $
    |y - x_k| <= |y - x| + |x - x_k| < delta + delta_k/2 <= delta_k/2 + delta_k/2 = delta_k.
  $
  Therefore, we have $x, y in V_(delta_k) (x_k)$, and so indeed $f(x) <= f(y)$.

  Consider a natural number $N$ such that $(b - a)/N < delta$.
  Then by the above claim, we have $f(a + k/N (b - a)) <= f(a + (k+1)/N (b - a))$ for all $0 <= k < N$.
  Therefore, we can conclude that
  $
    f(a) = f(a + 0/N (b-a)) <= f(a + 1/N (b-a)) <= dots.c <= f(a + N/N (b-a)) = f(b)
  $
]