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
  title: "MAT 127A Discussion 9 Notes",
  author: "Chen Liang",
  date: "November 25, 2025",
)

= More Functional Limits

#exercise[
  #text(dark-magenta)[(Warm-up)]
  Let $g(x) = root(5, x)$.
  Prove that $lim_(x -> c) g(x) = root(5, c)$ for all point $c > 0$. (
    The identity $a^5 - b^5 = (a - b)(a^4 + a^3 b + a^2 b^2 + a b^3 + b^4)$ will be helpful.
    Try $a = root(5, x)$ and $b = root(5, c)$.
  )
]
#proof[
  Let $epsilon > 0$.
  Note that for all $x in RR$, if we set $a = root(5, x)$ and $b = root(5, c)$, then we have
  $
    abs(root(5, x) - root(5, c)) = abs(a - b) = abs(a^5 - b^5) / (a^4 + a^3 b + a^2 b^2 + a b^3 + b^4),
  $
  and if we further assume $x > 0$, then we have
  $
    abs(root(5, x) - root(5, c)) <= abs(a^5 - b^5) / (b^4) = abs(x - c) / (root(5, c^4)).
  $
  Now, choose $delta = min{c, epsilon root(5, c^4)}$.
  To verify that this choice of $delta$ works, fix arbitrary $x in RR$ with $0 < abs(x - c) < delta$, then observe that $abs(x - c) < c$ implies $x > 0$, and therefore
  $
    abs(root(5, x) - root(5, c)) <= abs(x - c) / (root(5, c^4)) < (epsilon root(5, c^4)) / (root(5, c^4)) = epsilon.
  $
]

Recall the sequential criterion for functional limits.
Given a function $f : A -> RR$ and a limit point $c$ of $A$, the following two statements are equivalent:
#[
  #set enum(numbering: "(i)")
  + $lim_(x -> c) f(x) = L$.
  + For all sequences $(x_n)$ in $A$ satisfying $x_n != c$ for all $n$ and $(x_n) -> c$, it follows that $(f(x_n)) -> L$.
]

#exercise[
  Use the algebraic limit theorem for sequential limits to prove the following.
  Let $f$ and $g$ be functions defined  on a domain $A subset RR$, and assume $lim_(x -> c) f(x) = L$ and $lim_(x->c) g(x) = M$ for some limit point $c$ of $A$.
  Then, $lim_(x->c) f(x) g(x) = L M$.
]
#proof[
  It suffices to show that for all sequences $(x_n)$ in $A$ satisfying $x_n != c$ for all $n$ and $(x_n) -> c$, it follows that $(f(x_n) g(x_n)) -> L M$.
  Since we have $lim_(x -> c) f(x) = L$ and $lim_(x->c) g(x) = M$, the sequential criterion for functional limits tells us that $(f(x_n)) -> L$ and $(g(x_n)) -> M$.
  Thus, by the algebraic limit theorem for sequential limits, we have $(f(x_n) g(x_n)) -> L M$, as desired.
]

This is one of pieces of the algebraic limit theorem for functional limits.
The full algebraic limit theorem for functional limits says that under the same assumptions, we have
#[
  #set enum(numbering: "(i)")
  + $lim_(x -> c) k f(x) = k L$ for all $k in RR$,
  + $lim_(x -> c) (f(x) + g(x)) = L + M$,
  + $lim_(x -> c) f(x) g(x) = L M$,
  + $lim_(x -> c) f(x) \/ g(x) = L \/ M$ provided $M != 0$.
]
Using the algebraic limit theorem, one can easily show that polynomials are continuous.

Function composition may not behave nicely with functional limits.

#exercise[
    #text(dark-magenta)[(Exercise 4.3.4)]
    Assume $f$ and $g$ are defined on all of $RR$ and that $lim_(x -> p) f(x) = q$ and $lim_(x -> q) g(x) = r$.
    + Disprove the claim that $lim_(x -> p) g(f(x)) = r$ by verifying that
      $
        f(x) = 0
        quad "and" quad
        g(x) = cases(
          1 "if" x = 0\,,
          0 "if" x != 0
        )
      $
      is a counterexample.
      #box(width: 1fr)
    + Show that if $g(q) = r$, then $lim_(x -> p) g(f(x)) = r$.
]
#proof[
  + We have $lim_(x -> 0) f(x) = 0$ and $lim_(x -> 0) g(x) = 0$, but $lim_(x -> 0) g(f(0)) = lim_(x -> 0) 1 = 1$.

  + Let $epsilon > 0$.
    Since $lim_(x -> q) g(x) = r$, there exists $delta' > 0$ such that if $0 < abs(y - q) < delta'$, then $abs(g(y) - r) < epsilon$.
    Moreover, since $g(q) = r$, we have $abs(g(y) - r) = 0 < epsilon$ for $y = q$, and so we can conclude that if $abs(y - q) < delta'$, then $abs(g(y) - r) < epsilon$.
    Now, we can find the desired $delta > 0$ by noting that $lim_(x -> p) f(x) = q$ implies that there exists there exists $delta > 0$ such that if $0 < abs(x - p) < delta$, then $abs(f(x) - q) < delta'$, which then implies $abs(g(f(x)) - r) < epsilon$.
]

= Continuous Functions

Recall the characterization of continuity.
Let $f : A -> RR$, and let $c in A$.
The function $f$ is continuous at $c$ if and only if any one of the following three conditions is met:
#[
  #set enum(numbering: "(i)")
  + #define[(Definition)] For all $epsilon > 0$, there exists a $delta > 0$ such that $abs(x - c) < delta$ (and $x in A$) implies $abs(f(x) - f(c)) < epsilon$;
  + For all $epsilon > 0$, there exists a $delta > 0$ with the property that $f(V_delta (c) inter A) subset V_epsilon (f(c))$;
  + For all $(x_c) -> c$ (with $x_n in A$ for all $n$), it follows that $(f(x_n)) -> f(c)$.
]
If $c$ is a limit point of $A$, then the above conditions are equivalent to
#[
  #set enum(numbering: "(iv)")
  + $lim_(x -> c) f(x) = f(c)$.
]
Note that if $c$ is an isolated point of $A$, it still makes sense to say that $f$ is continuous at $c$ even though it does not make sense to talk about $lim_(x -> c) f(x)$.

The previous exercise tells us that composition of continuous functions is continuous, and so composition of *continuous* functions behaves nicely with functional limits.

#exercise[
  Let $F$ be a closed subset of $RR$ and $f$ be a continuous function defined on $RR$.
  Decide if the following statements are always true.
  If not, provide a counterexample.
  + The set $f(F)$ is closed.
  + The set $f^(-1) (F)$ is closed.
]
#proof[
  + This is not always true.
    Consider $f(x) = e^x$ and $F = RR$, then we have $f(F) = (0, oo)$, which is not closed.
    #remark[
      Note the the only examples are those with unbounded $F$ because image of a compact set under a continuous function is always compact.
    ]

  + This is always true.
    To see this, let $(x_n)$ be a sequence in $f^(-1) (F)$ converging to some $x$.
    We wish to show that $x in f^(-1) (F)$, which is to say $f(x) in F$.
    Since $f$ is continuous at $x$, we have $(f(x_n)) -> f(x)$, and because $f(x_n) in F$ for all $n$ and $F$ is closed, we must have $f(x) in F$, as desired.
]