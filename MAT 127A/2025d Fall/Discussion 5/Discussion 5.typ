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

// #let appreciation(body) = showybox(
//   frame: (
//     border-color: red,
//     body-color: white.darken(10%),
//     thickness: (left: 2pt),
//     radius: 0pt,
//   ),
//   body,
// )

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
  ("not", "⊈"),
)
#let supset = symbol(
  "⊇",
  ("simple", "⊃"),
  ("not", "⊉"),
)

#let note(body) = box(text(body, font: "PT Mono"), fill: yellow.lighten(75%), inset: 3pt, baseline: 3pt, radius: 5pt)
#let my-box(body) = box(body, stroke: 1pt, inset: 3pt, baseline: 3pt)

#make-title(
  title: "MAT 127A Discussion 5 Notes",
  author: "Chen Liang",
  date: "October 28, 2025",
)

= Cauchy sequence

A sequence $(a_n)$ is #define[Cauchy] if for every $epsilon > 0$, there exists $N in NN$ such that for all $n, m >= N$, we have $abs(a_n - a_m) < epsilon$.

#remark[
  A implicit alternative characterization is that $(a_n)$ is Cauchy if and only if for every $epsilon > 0$, there exists $N in NN$ such that for all $n, m >= N$ such that $n >= m$, we have $abs(a_n - a_m) < epsilon$.

  We like the original definition because it is more applicable, but when proving that a sequence is Cauchy, we often implicitly use the alternative characterization under the disguise of "without loss of generality, assume $n >= m$."
]

Perhaps the most important theorem about Cauchy sequences is that a sequence converges if and only if it is Cauchy.
This is because that normally to show that a sequence $(a_n)$ converges, we need to propose a limit $a$ first and then verify that $a_n -> a$.
However, sometimes the very thing we want to show is that the limit of $(a_n)$ exists, and the Cauchy criterion allows us to construct the limit by merely examining the terms of the sequence itself.
Consider the following exercise.

#exercise[
  Let $(a_1, a_2, a_3, a_4, ...)$ be a sequence with $a_n in {0, 1, 2, 3, ..., 9}$ for all $n in NN$.
  Show that $0.overline(a_1 a_2 a_3 a_4 dots.c)$ exists by showing that the sequence $(b_n)$ defined by
  $
    b_1 = 0.overline(a_1), quad b_2 = 0.overline(a_1 a_2), quad b_3 = 0.overline(a_1 a_2 a_3), quad b_4 = 0.overline(a_1 a_2 a_3 a_4), quad dots.c
  $
  and in general,
  $
    b_n = sum_(k=1)^n (a_k)/(10^k)
  $
  is Cauchy and hence converges.

  _I know we can also use monotone convergence theorem, but bare with me!_
]
#proof[
  We will show that $(b_n)$ is Cauchy.
  Given $epsilon > 0$, we wish to find $N in NN$ such that for all $n, m >= N$, we have $abs(b_n - b_m) < epsilon$.
  If $n >= m$, we see that
  $
    abs(b_n - b_m) = abs(sum_(k=m+1)^n (a_k)/(10^k)) &<= sum_(k=m+1)^n (9)/(10^k) \
    &<= 1/(10^m) - 1/(10^n) < 1/(10^m).
  $
  Therefore, let us choose an $N in NN$ such that $1/(10^N) < epsilon$ (such as an $N$ with $1/N < epsilon$ using the Archimedean property because $1/(10^N) < 1/N$).
  Then, for all $n, m >= N$, if we assume without loss of generality that $n >= m$, then
  $
    abs(b_n - b_m) < 1/(10^m) <= 1/(10^N) < epsilon.
  $
  Therefore, $(b_n)$ is Cauchy, and hence it converges.
  We denote its limit by $0.overline(a_1 a_2 a_3 a_4 dots.c)$.
]

The debate whether to use monotone convergence theorem or Cauchy criterion depends on how we ultimately want to define $0.overline(a_1 a_2 a_3 a_4 dots.c)$
Do we want it to represent the supremum of a set?
Or do we want it to represent the limit of a sequence?

Historically, people did thought of real numbers as limits of sequences.
They thought of the construction of the real numbers as a procedure of producing rational numbers that get closer and closer together.
For example, approximating the circumference of a circle using polygons.

#figure(
  canvas({
    import cetz.draw: *

    let r = 0.8
    let s = 0.5
    let N = 5
    let num-sides(n) = 3 + n

    for n in range(N) {
      let center = (((n * (2 * r + s) + r, 0)))
      circle(center, radius: r)
      polygon(center, num-sides(n), radius: r)
    }
  }),
  caption: [
    Approximating a circle using polygons with increasing number of sides.
    The perimeters of the polygons form a Cauchy sequence.
  ]
)

If there is another introductory real analysis textbook that matches Abbott's quality, we might end up defining real numbers by the Cauchy criterion rather than the axiom of completeness.

= Cauchy criterion $=>$ Axiom of completeness

Let us recall that the proof of the Bolzano-Weierstrass theorem which states that
#align(center)[
  every bounded sequence has a convergent subsequence.
]
The proof begins by fixing an arbitrary bounded sequence $(x_n)$, so there exists some $M > 0$ such that $abs(x_n) <= M$ for all $n in NN$.
+ Let $[a_1, b_1] = [-M, M]$, then we consider the two bisected intervals $[-M, 0]$ and $[0, M]$.
  One of them must contain infinitely many terms of the sequence $(x_n)$ (otherwise, the sequence would contain finitely many terms which is ridiculous).
  If $[-M, 0]$ contains infinitely many terms, we let $[a_2, b_2] = [-M, 0]$; otherwise, we let $[a_2, b_2] = [0, M]$.
+ In any case, $[a_2, b_2]$ has infinitely many terms of the sequence $(x_n)$, so we can repeat the process to obtain nested bounded closed intervals $[a_3, b_3]$, $[a_4, b_4]$, ..., all of which contain infinitely many terms of the sequence $(x_n)$ and satisfy
  $
    lim (b_n - a_n) = lim (2M)/(2^(n-1)) = 0.
  $
+ These three properties allow us to construct a convergent subsequence.
 - Nested interval property gives us a candidate limit $x$ that lies in all intervals $[a_n, b_n]$ for $n in NN$.
 - Since each interval $[a_n, b_n]$ contains infinitely many terms of the sequence $(x_n)$, we can pick a term $x_(n_k) in [a_k, b_k]$ from each interval while ensuring that the indices $n_1 < n_2 < n_3 < dots.c$ are strictly increasing.
 - The fact that $lim (b_n - a_n) = 0$ will allow us to show that $x_(n_k) -> x$.

The key idea is repeated bisection of intervals and at each step, pick the interval that satisfies whatever desired property.
This technique will show up over and over again (proving connectedness, compactness, intermediate value theorem, etc.), so mastery of either this or Bolzano-Weierstrass theorem (which packages this technique) is essential.

The following exercise is involved, but after completing the core construction with bisection, the proof is a routine exercise of carrying out the definitions of limits and playing around with quantifiers.
The benefit you get mastering it is tantamount to the its difficulty, and it will pay off each time we use the bisection method or invoke theorems that package this method.

#exercise[
  Assuming Cauchy criterion, follow the outline to prove axiom of completeness:
  if $A$ is a nonempty bounded subset of $RR$, then there exists a least upper bound of $A$.
  + Find an interval $[a_1, b_1]$ whose left endpoint $a_1$ is not an upper bound and whose right endpoint $b_1$ is an upper bound of $A$.
    // Find an interval $[a_1, b_1]$ that intersects $A$ and whose right endpoint $b_1$ is an upper bound of $A$.
  + Show that if $[a_k, b_k]$ is an interval whose left endpoint $a_k$ is not an upper bound and whose right endpoint $b_k$ is an upper bound of $A$, then either $[a_k, (a_k + b_k)/2]$ or $[(a_k + b_k)/2, b_k]$ satisfies the same property.

    Thus, we can let $[a_(k+1), b_(k+1)]$ be either of the two intervals that satisfies the property.
    By repeating the process, we obtain a sequence of nested intervals $[a_n, b_n]$ whose left endpoints are not upper bounds of $A$ and whose right endpoints are upper bounds of $A$, and that they satisfy
    $
      lim (b_n - a_n) = lim (b_1 - a_1)/(2^(n-1)) = 0.
    $
  + Show that $(a_n)$ or $(b_n)$ is Cauchy (both of them are, pick your favorite).
  + By the Cauchy criterion, your pick converges to some limit $x$.
    Use the algebraic limit theorem (whose proof does not use axiom of completeness) to show that the other pick also converges to $x$.
  + Fix arbitrary $epsilon > 0$, show that $x - epsilon$ is not an upper bound of $A$ and that $x + epsilon$ is an upper bound of $A$.
  + Prove that $x$ is the least upper bound of $A$.

  _Each part is its own question that can be done if you assume that the previous parts are true._
]
#proof[
  Since $A$ is nonempty, we can find $a in A$ and set $a_1 = a - 1$, so that $a_1$ is not an upper bound of $A$.
  Because $A$ is bounded, we can find an upper bound $b_1$ of $A$, and hence a desired interval $[a_1, b_1]$.

  Suppose that $[a_k, b_k]$ is an interval such that $a_k$ is not an upper bound and $b_k$ is an upper bound of $A$.
  If $(a_k + b_k)/2$ is an upper bound of $A$, we can set $[a_(k+1), b_(k+1)] = [a_k, (a_k + b_k)/2]$, and if not, we can set $[a_(k+1), b_(k+1)] = [(a_k + b_k)/2, b_k]$.
  In either case, we have that $a_(k+1)$ is not an upper bound and $b_(k+1)$ is an upper bound of $A$.
  By repeating the process, we obtain a sequence of nested intervals $[a_n, b_n]$ whose left endpoints are not upper bounds of $A$ and whose right endpoints are upper bounds of $A$, and that they satisfy
  $
    lim (b_n - a_n) = lim (b_1 - a_1)/(2^(n-1)) = 0.
  $
  We will show that $(a_n)$ is Cauchy.
  Fix arbitrary $epsilon > 0$.
  Since $lim (b_n - a_n) = 0$, we can find some $N in NN$ such that for all $m >= N$, we have $b_m - a_m < epsilon$.
  Furthermore, since for all $n >= m$, we have $a_n in [a_m, b_m]$, so we get
  $
    a_n - a_m <= b_m - a_m.
  $
  Thus, this $N$ works to show that $(a_n)$ is Cauchy because for all $n, m >= N$, if we assume without loss of generality that $n >= m$, then
  $
    abs(a_n - a_m) = a_n - a_m <= b_m - a_m < epsilon.
  $

  By the Cauchy criterion, $(a_n)$ converges to some limit $x$.
  By the algebraic limit theorem, we have
  $
    lim (b_n) = lim (b_n - a_n) + lim (a_n) = x.
  $
  Let $epsilon > 0$ be arbitrary, then $a_n -> x$ tells us that there exists some $n in NN$ such that $x - epsilon < a_n$, but $a_n$ is not an upper bound of $A$, so neither is $x - epsilon$ (if it were, then $a_n$ would have to be an upper bound).
  On the other hand, $b_n -> x$ tells us that there exists some $n in NN$ such that $b_n < x + epsilon$, but since $b_n$ is an upper bound of $A$, we have that $x + epsilon$ is also an upper bound of $A$.

  Finally, we show that $x$ is the least upper bound of $A$.
  First, if $x$ were not an upper bound of $A$, then there exists some $a in A$ such that $a > x$.
  However, we also know that $x + (a - x)/2$ is an upper bound of $A$, and this contradicts the fact that $x + (a - x)/2 = (a + x)/2 < (2a)/2 =  a$.
  It is clear that $x$ is the least upper bound because $x - epsilon$ is not an upper bound of $A$ for all $epsilon > 0$.
]