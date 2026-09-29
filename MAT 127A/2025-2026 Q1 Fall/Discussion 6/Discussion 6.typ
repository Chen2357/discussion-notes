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
  ("simple", "⊂"),
  ("p", "⊈"),
)
#let supset = symbol(
  "⊇",
  ("simple", "⊃"),
  ("p", "⊉"),
)

#let note(body) = box(text(body, font: "PT Mono"), fill: yellow.lighten(75%), inset: 3pt, baseline: 3pt, radius: 5pt)
#let my-box(body) = box(body, stroke: 1pt, inset: 3pt, baseline: 3pt)

#make-title(
  title: "MAT 127A Discussion 6 Notes",
  author: "Chen Liang",
  date: "November 4, 2025",
)

#set enum(numbering: "(a)")

= Open Sets

Recall that a set $O subset RR$ is #define[open] if
#align(center)[
  for every $x in O$, there exists $epsilon > 0$ such that $V_epsilon (x) subset O$
]
where $V_epsilon (x) = (x - epsilon, x + epsilon)$ is the $epsilon$-neighborhood of $x$.

#exercise[
  Show that if $a < b$, then the intervals $(a, oo)$, $(-oo, b)$, and $(a, b)$ are open sets.
]
#proof[
  Let us prove that $(a, oo)$ is open.
  Let $x in (a, oo)$ be arbitrary.
  Then, we have $epsilon = x - a > 0$.
  It is clear that if $y in V_epsilon (x)$, then $y > x - epsilon = a$, so $V_epsilon (x) subset (a, oo)$.

  A similar argument works for $(-oo, b)$.
  Let $x in (-oo, b)$ be arbitrary.
  Then, we have $epsilon = b - x > 0$.
  It is clear that if $y in V_epsilon (x)$, then $y < x + epsilon = b$, so $V_epsilon (x) subset (-oo, b)$.

  Finally, let us prove that $(a, b)$ is open.
  Let $x in (a, b)$ be arbitrary.
  Since $(a, oo)$ and $(-oo, b)$ are open, there exist $epsilon_1, epsilon_2 > 0$ such that $V_epsilon_1 (x) subset (a, oo)$ and $V_epsilon_2 (x) subset (-oo, b)$.
  Let $epsilon = min (epsilon_1, epsilon_2)$, then we have
  $
    V_epsilon (x) subset V_epsilon_1 (x) subset (a, oo) quad "and" quad V_epsilon (x) subset V_epsilon_2 (x) subset (-oo, b),
  $
  and thus $V_epsilon (x) subset (a, b)$.
]

The argument used to prove that $(a, b)$ is open can be generalized verbatim to prove that the binary intersection of any two open sets is open.
In fact, we can generalize it even further to prove that the intersection of finitely many open sets is open (where does it fail for infinite intersections?).

= Closed Sets

Recall that a point $x in RR$ is called a #define[limit point] of a set $A$ if
#align(center)[
  for every $epsilon > 0$, there exists $y in V_epsilon (x) inter A$ such that $y != x$.
]
or in a more colloquial language, $V_epsilon (x) inter A$ contains a point other than $x$.
Negating this definition, we obtain that a point $x$ is not a limit point of $A$ if
#align(center)[
  there exists $epsilon > 0$ such that $V_epsilon (x) inter A subset {x}$.
]

A set $A subset RR$ is called #define[closed] if it contains all of its limit points.

This definition for closed sets is very applicable to prove theorems, but it makes proving that a set is closed quite challenging sometimes.
Even proving that a simple interval like $[a, b]$ is closed would often demand an argument by contradiction.
Thus, it is prove a set $A$ is closed by proving the contrapositive that
#align(center)[
  if $x in.not A$, then $x$ is not a limit point of $A$.
]
We can further unwrap the definition of limit point to obtain that $A$ is closed if and only if "for every $x in.not A$, there exists $epsilon > 0$ such that $V_epsilon (x) inter A subset {x}$," but since $x in.not A$, $V_epsilon (x) inter A$ can never contain $x$, so this is equivalent to
#align(center)[
  for every $x in.not A$, there exists $epsilon > 0$ such that $V_epsilon (x) inter A = emptyset$.
]
This characterization of closed sets is useful in the following example.

#exercise[
  + Let $a in RR$, show that the set $[a, oo)$ is closed.
  + In general, show that the complement of any open set is closed.

  _By the way, you should also try a direct proof of (a) using order limit theorem._
]
#remark[
  Part (a) can also be proven directly using the order limit theorem, but that approach would not generalize to part (b).

  Also, part (b) goes the other way too.
  The complement of any closed set is open.
]
#proof[
  + To show that a set is closed, it suffices to show that if a point is not in the set, then it is not a limit point of the set (hence all limit points are contained in the set).
    Thus, suppose that $x$ is not in $[a, oo)$, we wish to show that $x$ is not a limit point of $[a, oo)$.
    Since $x in.not [a, oo)$ implies that $x < a$, we have $epsilon = a - x > 0$.
    It is clear that $V_epsilon (x) inter [a, oo)$ is empty because $y in V_epsilon (x)$ implies that $y < x + epsilon = a$ but $y in [a, oo)$ implies that $y >= a$.
    Thus, $x$ is not a limit point of $[a, oo)$.

  + Let $O subset RR$ be an open set, then to show that $O^c$ is closed, it suffices to show that for arbitrary $x$ not in $O^c$, $x$ is not a limit point of $O^c$.
    Since $x in O$ and $O$ is open, there exists $epsilon > 0$ such that $V_epsilon (x) subset O$.
    It follows that $V_epsilon (x) inter O^c$ is empty, so $x$ is not a limit point of $O^c$.
]

On the other hand, the "default" definition of closed set is very useful to prove theorems such as the following.

#exercise[
  Let $F$ be a closed set and $(a_n)$ be a sequence in $F$ that converges to some real number $a$.
  Show that $a in F$.
]
#proof[
  For the sake of contradiction, suppose that $a$ is not in $F$.
  We will find a contradiction by showing that $a$ is a limit point of $F$, and hence must be in $F$ since $F$ is closed.
  Let $epsilon > 0$ be arbitrary.
  As a consequence of $a_n -> a$, we have that there exists $N in NN$ such that $abs(a_N - a) < epsilon$.
  Note that $a_N in V_epsilon (a) inter F$ and $a_N != a$ (because $a_N in F$ but $a in.not F$), so we have found a point in $V_epsilon (a) inter F$ other than $a$.
  Thus, $a$ is a limit point of $F$ which must actually be in $F$.
]

#exercise[
  #text(dark-magenta)[(Connectedness of $RR$)]
  Let $A$ and $B$ be two nonempty closed sets such that $A union B = RR$.
  Show that $A inter B != emptyset$.

  _Hint: use the bisection method to construct two sequences in $A$ and $B$ respectively that converge to the same limit._
]
#proof[
  Since $A$ and $B$ are nonempty, let us pick $a_0 in A$ and $b_0 in B$.
  Suppose we have $a_k in A$ and $b_k in B$, then we can define $a_(k+1) in A$ and $b_(k+1) in B$ by the following procedure.
  - If $(a_k + b_k) / 2 in A$, then let $a_(k+1) = (a_k + b_k) / 2$ and $b_(k+1) = b_k$.
  - Otherwise, we must have $(a_k + b_k) / 2 in B$ because $A union B = RR$, so let $a_(k+1) = a_k$ and $b_(k+1) = (a_k + b_k) / 2$.
  This process produces two sequences $(a_n)$ in $A$ and $(b_n)$ in $B$ such that
  $
    lim (a_n - b_n) = lim (a_0 - b_0) / 2^n = 0,
  $
  Moreover, $(a_n)$ and $(b_n)$ are convergent with the same limit $x$ because of the following.
  - If $a_0 <= b_0$, then $(a_n)$ is increasing and bounded by $b_0$, so it converges to some limit $x$.
    Using the algebraic limit theorem, we can also conclude that $(b_n) -> x$.
  - If $a_0 > b_0$, then $(b_n)$ is increasing and bounded by $a_0$, so it converges to some limit $x$.
    Using the algebraic limit theorem, we can also conclude that $(a_n) -> x$.
  Since closed sets contain sequential limits of sequences in them, we have $x in A$ and $x in B$, so $x in A inter B$.
]