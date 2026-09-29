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
  title: "MAT 127A Discussion 10 Notes",
  author: "Chen Liang",
  date: "December 2, 2025",
)

= Uniform Continuity

A function $f : A -> RR$ is uniformly continuous on $A$ if for every $epsilon > 0$, there exists a $delta > 0$ such that for all $x, y in A$, $abs(x - y) < delta$ implies $abs(f(x) - f(y)) < epsilon$.

#remark[
  Compare this definition with continuity: $f$ is continuous on $A$ if for every $c in A$ and $epsilon > 0$, there exists a $delta > 0$ such that for all $x in A$, $abs(x - c) < delta$ implies $abs(f(x) - f(c)) < epsilon$.
  To prove continuity, the choice of $delta$ can depend on both $epsilon$ and the point $c$.

  In the definition of uniform continuity, $y$ takes the role of $c$, but it is introduced after $delta$ which means that the choice of $delta$ can only depend on $epsilon$.
]

#exercise[
  #text(dark-magenta)[(Exercise 4.4.1)]
  Let $f(x) = x^3$.
  Show that $f$ is uniformly continuous on any bounded subset of $RR$.
]
#proof[
  Let $A subset RR$ be bounded.
  Thus, there exists $M > 0$ such that for all $x in A$, we have $abs(x) <= M$.
  Let $epsilon > 0$.
  Note that for all $x, y in A$, we have
  $
    abs(f(x) - f(y)) = abs(x^3 - y^3) = abs(x - y) abs(x^2 + x y + y^2) <= 3 M^2 abs(x - y).
  $
  Thus, if we set $delta = epsilon / (3 M^2)$, then for all $x, y in A$, we have that $abs(x - y) < delta$ implies
  $
    abs(f(x) - f(y)) <= 3 M^2 abs(x - y) < 3 M^2 delta = epsilon.
  $
]

Theorem 4.4.5 relates sequences and the absence of uniform continuity:
A function $f : A -> RR$ fails to be uniformly continuous on $A$ if and only if there exist $epsilon_0 > 0$ and sequences $x_n, y_n in A$ such that $abs(x_n - y_n) -> 0$ but $abs(f(x_n) - f(y_n)) >= epsilon_0$ for all $n in NN$.

This result is important because we have defined compactness in terms of sequences and have gave many concepts sequential characterizations (e.g., continuity, closed sets, etc.).
When we want to study the relation between uniform continuity and those concepts, Theorem 4.4.5 will be very useful.

#exercise[
  + #text(dark-magenta)[(Exercise 4.4.2)] Show that $f(x) = 1/x$ is not uniformly continuous on $(0, 1)$.
  + Show that $f(x) = x^2$ is not uniformly continuous on $RR$.
]
#proof(qed: none)[
  + Let $x_n = 1/n$ and $y_n = 1/(n + 1)$ for all $n in NN$, and fix $epsilon_0 = 1$.
    Then, we have
    $
      abs(x_n - y_n) = abs(1/n - 1/(n + 1)) = 1/(n(n + 1)) -> 0,
    $
    but
    $
      abs(f(x_n) - f(y_n)) = abs(n - (n + 1)) = 1 >= epsilon_0.
    $
    Thus, $f$ is not uniformly continuous on $(0, 1)$.

  + Let $x_n = n$ and $y_n = n + 1/n$ for all $n in NN$, and fix $epsilon_0 = 2$.
    Then, we have
    $
      abs(x_n - y_n) = abs(n - (n + 1/n)) = 1/n -> 0,
    $
    but
    $
      abs(f(x_n) - f(y_n)) = abs(n^2 - (n + 1/n)^2) = abs(n^2 - (n^2 + 2 + 1/n^2)) = 2 + 1/(n^2) > epsilon_0.
    $
    Thus, $f$ is not uniformly continuous on $RR$. #h(1fr) $qed$
]

#exercise[
  + Give an example of a continuous function $f$ on a bounded set $A$ such that $f(A)$ is unbounded.
  + Show that if $f$ is uniformly continuous on a bounded set $A$, then $f(A)$ is bounded.
]
#proof(qed: none)[
  + An example is $f(x) = 1/x$ on the bounded set $A = (0, 1)$.
    We have $f(A) = (1, oo)$.
  + #text(red)[_Proof 1_. (Using Theorem 4.4.5 and Bolzano-Weierstrass theorem)]
    Suppose for the sake of contradiction that $f(A)$ is unbounded.
    Let $x_1 in A$ be arbitrary (note that $f(A)$ being unbounded implies that $A$ is nonempty).
    Recursively, after we fix $x_k in A$, we can find $x_(k + 1) in A$ such that
    $
      abs(f(x_(k + 1))) >= abs(f(x_k)) + 1
    $
    because $f(A)$ is unbounded.
    Since $abs(f(x_(k + 1))) - abs(f(x_k)) >= 1$ for all $k in NN$, we know that for all $m, n in NN$ with $m > n$, we have
    $
      abs(f(x_m) - f(x_n)) >= abs(f(x_m)) - abs(f(x_n)) >= m - n >= 1.
    $
    Now, since $A$ is bounded, by the Bolzano-Weierstrass theorem, there exists a subsequence $(x_(n_k))$ of $(x_n)$ converging to some limit point $c in RR$.
    Thus, we have
    $
      0 <= abs(x_(n_(k + 1)) - x_(n_k)) <= abs(x_(n_(k + 1)) - c) + abs(x_(n_k) - c),
    $
    which implies that $abs(x_(n_(k + 1)) - x_(n_k)) -> 0$ by the squeeze theorem.
    However, we have
    $
      abs(f(x_(n_(k + 1))) - f(x_(n_k))) >= 1
    $
    This contradicts with the fact that $f$ is uniformly continuous on $A$, thus, $f(A)$ must be bounded.

    #text(red)[_Proof 2_. (Using the definition of uniform continuity)]
    Let $epsilon = 1$.
    Since $f$ is uniformly continuous on $A$, there exists $delta > 0$ such that for all $x, y in A$, if $abs(x - y) < delta$, then $abs(f(x) - f(y)) < 1$.
    Since $A$ is bounded, there exists $M > 0$ such that $A subset [-M, M]$.
    We can find a finite cover $[-M, M]$ by nonempty intervals of length less than $delta$, say, $(a_1, b_1), (a_2, b_2), ..., (a_N, b_N)$.
    Thus, we have $A subset union_(i = 1)^N (a_i, b_i) inter A$.
    Now, uniform continuity implies that for each $i$ and every two points $y_1, y_2 in f((a_i, b_i) inter A)$, we have $abs(y_1 - y_2) < 1$.
    In particular, we have
    $
      f((a_i, b_i) inter A) subset V_1 (f((a_i + b_i)/2)).
    $
    Thus, we have
    $
      f(A) subset union_(i = 1)^N f((a_i, b_i) inter A) subset union_(i = 1)^N V_1 (f((a_i + b_i)/2)),
    $
    which is bounded because finite unions of bounded sets is bounded.
    #h(1fr) $qed$
]