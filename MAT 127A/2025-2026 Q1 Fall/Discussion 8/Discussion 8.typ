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
  title: "MAT 127A Discussion 8 Notes",
  author: "Chen Liang",
  date: "November 18, 2025",
)

= Functional limits

Recall that given a function $f : A -> RR$ and a limit point $c$ of $A$, we say that $lim_(x -> c) f(x) = L$ provided that, for all $epsilon > 0$, there exists a $delta > 0$ such that for all $x in A$ with $0 < |x - c| < delta$, we have $|f(x) - L| < epsilon$.

The intuition is that, we have $lim_(x -> c) f(x) = L$ if and only if for every $epsilon > 0$, there exists a $delta > 0$ such that after we disregard the values of $f$ at $c$ and anywhere outside of $V_delta (c)$, the values of $f$ over $V_delta (c) without {c}$ are all contained in $V_epsilon (L)$.

#exercise[
  #text(dark-magenta)[(Example 4.2.2)]
  Show that then $lim_(x -> 2) (3x + 1) = 7$.
]
#proof[
  Let $epsilon > 0$.
  Notice that
  $
    abs((3x + 1) - 7) = abs(3x - 6) = 3 abs(x - 2).
  $
  Thus, if we choose $delta = epsilon/3$, then $0 < abs(x - 2) < delta$ implies $abs((3x + 1) - 7) < 3 (epsilon / 3) = epsilon$.
]

#remark[
  Pay attention to how we do not write $abs((3x + 1) - 7) = abs(3x - 6) = 3 abs(x - 2) < epsilon$ when making the observation.
]

#exercise[
  + #text(dark-magenta)[(Example 4.2.2)] Show that $lim_(x -> 2) x^2 = 4$.
  + Use all previous results in this discussion to show that $lim_(x -> 2) (x^2 + 3x + 1) = 11$.
]
#proof[
  + A little algebra reveals
    $
      abs(x^2 - 4) = abs(x + 2) abs(x - 2).
    $
    Notice how we can control the size of $abs(x + 2)$ simply by keeping $abs(x - 2)$ (which is something we can control) small.
    For precisely, if we have that if $abs(x - 2) < 1$, then $abs(x + 2) = abs(x - 2 + 4) <= abs(x-2) + 4 < 5$.

    Let $epsilon > 0$, then we can choose $delta = min {1, epsilon/5}$.
    If $0 < abs(x - 2) < delta$, then we have $abs(x + 2) <= abs(x-2) + 4 < 5$, and so
    $
      abs(x^2 - 4) = abs(x + 2) abs(x - 2) < 5 delta <= 5 (epsilon/5) = epsilon.
    $

  + Fix $epsilon > 0$.
    Observe that
    $
      abs((x^2 + 3x + 1) - 11) = abs((x^2 - 4) + ((3x + 1) - 7)) <= abs(x^2 - 4) + abs((3x + 1) - 7).
    $
    We will make sure that $abs(x^2 - 4)$ and $abs((3x + 1) - 7)$ are both less than $epsilon/2$ separately.
    Since $lim_(x -> 2) x^2 = 4$, there exists $delta_1 > 0$ such that if $0 < abs(x - 2) < delta_1$, then $abs(x^2 - 4) < epsilon/2$.
    Similarly, since $lim_(x -> 2) (3x + 1) = 7$, there exists $delta_2 > 0$ such that if $0 < abs(x - 2) < delta_2$, then $abs((3x + 1) - 7) < epsilon/2$.
    By setting $delta = min {delta_1, delta_2}$, we have that if $0 < abs(x - 2) < delta$, then
    $
      abs((x^2 + 3x + 1) - 11) <= abs(x^2 - 4) + abs((3x + 1) - 7) < epsilon/2 + epsilon/2 = epsilon.
    $
]

#remark[
  The second part of the previous exercise is a special case of the algebraic limit theorem for functional limits, and its proof is a specialized version of the proof of the algebraic limit theorem.
]

= Divergence criterion for functional limits

The direct negation of the definition of functional limits is actually somewhat difficult to work with.
Instead, when we are working with a divergent functional limit, it can be more convenient to use sequences.

#exercise[
  Given a function $f : A -> RR$ and a limit point $c$ of $A$, show that $lim_(x -> c) f(x) = L$ implies that all sequences $(x_n)$ in $A without {c}$ with $x_n -> c$ satisfy $f(x_n) -> L$.
]
#proof[
  Suppose that $lim_(x -> c) f(x) = L$ and $(x_n)$ is a sequence in $A without {c}$ with $x_n -> c$.
  Let $epsilon > 0$, then we wish to show that there exists $N in NN$ such that for all $n >= N$, we have $abs(f(x_n) - L) < epsilon$.
  Since $lim_(x -> c) f(x) = L$, we can control the size of $abs(f(x_n) - L)$ by controlling the size of $abs(x_n - c)$, which we can control since $x_n -> c$.
  More precisely, there exists $delta > 0$ such that
  $
    0 < abs(x - c) < delta quad "implies" quad abs(f(x) - L) < epsilon;
  $
  and there exists $N in NN$ such that
  $
    n >= N quad "implies" quad abs(x_n - c) < delta.
  $
  To verify that this $N$ works, let $n >= N$.
  Then we have $abs(x_n - c) < delta$ and because $x_n != c$, we have $0 < abs(x_n - c) < delta$, which implies $abs(f(x_n) - L) < epsilon$.
]

A direct consequence of the previous exercise is the following divergence criterion for functional limits:

#align(center)[
  #show: it => box(width: 80%, stroke: 1pt, inset: 7pt, it)
  #show: it => align(left, it)
  Let $f : A -> RR$ and assume that $c$ is a limit point of $A$.
  If there exist two sequences $(x_n)$ and $(y_n)$ in $A without {c}$ such that
  $
    lim x_n = lim y_n = c quad "but" quad lim f(x_n) != lim f(y_n),
  $
  then $lim_(x -> c) f(x)$ does not exist.
]

#exercise[
  Come up with and give brief justifications for each of the following requests.
  + A bounded function $f : RR -> RR$ whose functional limits $lim_(x -> c) f(x)$ exists for all $c != 0$ but fails to exist at $c = 0$.
  + A function $f : RR -> RR$ whose functional limits $lim_(x -> c) f(x)$ only exists when $c = 0$.
]
#proof[
  + Consider the function
    $
      f(x) = cases(
        1 & "if" x >= 0,
        -1 & "if" x < 0.
      )
    $
    For $c != 0$, if $c > 0$, then we can easily see that $lim_(x -> c) f(x) = 1$ (for every $epsilon > 0$, we can choose $delta = c/2$).
    Similarly, if $c < 0$, then we have $lim_(x -> c) f(x) = -1$.
    However, at $c = 0$, we can consider the sequences $x_n = 1/n$ and $y_n = -1/n$, both of which converge to $0$.
    However, we have $f(x_n) = 1$ for all $n$, so $lim f(x_n) = 1$; whereas we have $f(y_n) = -1$ for all $n$, so $lim f(y_n) = -1$.
    Thus, by the divergence criterion, $lim_(x -> 0) f(x)$ does not exist.

  + Consider the function
    $
      f(x) = cases(
        x & "if" x in QQ,
        0 & "if" x in.not QQ.
      )
    $
    For $c = 0$, we have $lim_(x -> 0) f(x) = 0$ because for every $epsilon > 0$, we can choose $delta = epsilon$, and then for all $x$ with $0 < abs(x - 0) < delta$, we have
    $
      abs(f(x) - 0) = x < delta = epsilon quad "if" x in QQ "and" \
      abs(f(x) - 0) = 0 < epsilon quad "if" x in.not QQ.
    $
    For $c != 0$, we can pick $a_n in QQ inter V_(1\/n) (c)$ and $b_n in (RR without QQ) inter V_(1\/n) (c)$ for each $n in NN$ to form by the density of rationals and irrationals.
    Then both sequences $(a_n)$ and $(b_n)$ converge to $c$.
    However, we have $lim f(a_n) = lim a_n = c$ and $lim f(b_n) = lim 0 = 0$.
    Thus, by the divergence criterion, $lim_(x -> c) f(x)$ does not exist for any $c != 0$.
]