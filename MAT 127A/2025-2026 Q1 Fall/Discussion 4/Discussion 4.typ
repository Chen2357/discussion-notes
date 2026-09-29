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

#let appreciation(body) = showybox(
  frame: (
    border-color: red,
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
  title: "MAT 127A Discussion 4 Notes",
  author: "Chen Liang",
  date: "October 21, 2025",
)

= Sequential Limits

A sequence $(a_n)_(n in NN)$ is said to #define[converge] to a number $a in RR$ if
#align(center)[
  for every $epsilon > 0$, there exists $N in NN$ such that for all $n >= N$, we have $abs(a_n - a) < epsilon$.
]
In this case, we write $lim_(n -> oo) a_n = a$ or $lim a_n = a$ or that $(a_n) -> a$ (read as $a_n$ tends to $a$).

#remark[
  The idea is that for every $epsilon > 0$, we can cut off the beginning of the sequence at some point $N$, and the remaining terms ${a_N, a_(N+1), a_(N+2), ...}$ will all lie within the $epsilon$-neighborhood of $a$.
]

When we learn a definition, we should also learn the negation of it.
A sequence $(a_n)$ does not converge to $x$ if and only if
#align(center)[
  there exists $epsilon > 0$ such that for every $N in NN$, there exists $n >= N$ such that $abs(a_n - x) >= epsilon$.
]
We say that $(a_n)$ #define[diverges] if it does not converge to any real number $x$.

// I will show you a template for a proof of convergence, but first, I want you to try to write down a proof with your group.

#exercise[
  Show that $lim_(n -> oo) 1/n = 0$.
]
#proof[
  #my-box[Let $epsilon > 0$ be arbitrary.]
  #note[#emoji.hand.wave] We wish to find an $N in NN$ such that $abs(1/n - 0) < epsilon$ for all $n >= N$.
  By the Archimedean property, #my-box[there exists $N in NN$] such that $1/N < epsilon$.
  Then, #my-box[for all $n >= N$], we have
  #align(center, rect[
    $
      abs(1/n - 0) = 1/n <= 1/N < epsilon.
    $
  ])
]

#note[#emoji.hand.wave:] Asserting the new goal after fixing $epsilon$ is useful but not required.
You can also write flavor text instead like "Our goal is to find some point in the sequence $(1/n)$ after which we have $abs(1/n - 0) < epsilon$."

The four key steps in a convergence proof for $a_n -> a$ are boxed.
1. "Let $epsilon > 0$ be arbitrary."
2. Demonstrate a choice for $N in NN$.
  This choice usually requires the most thinking which should be done prior to writing the proof.
3. "Assume $n >= N$."
4. With $N$ well chosen, it should be possible to show $abs(a_n - a) < epsilon$.
  If not, reconsider step 2.

#exercise[
  #text(dark-magenta)[(Do it after discussion!)]
  Come up with a template for a proof that a sequence $(a_n)$ diverges.

  _We will learn about the Cauchy criterion for convergence whose negation gives a simpler template for divergence, and it can be helpful to compare the two templates to appreciate the Cauchy criterion._
]

#exercise[
  Let $lim a_n = a$, then show that $lim (c a_n) = c a$ for all $c in RR$.
]

The above exercise is part of the Algebraic Limit Theorem (Theorem 2.3.3 in Abbott).
Let us _appreciate_ and _learn_ the proof writing style used by Abbott.
Pay attention to how math expressions blend into the text seamlessly, producing _readable_ sentences that can spoken just in ordinary language.

The proof below is taken from the textbook with annotations.

#proof[
  #note[#emoji.heart.purple#{}1] Consider the case where $c != 0$.
  First, let $epsilon$ be some arbitrary positive number.
  #note[#emoji.heart.purple#{}2] Our goal is to find some point in the sequence $(c a_n)$ after which
  $
    abs(c a_n - c a) < epsilon.
  $
  #note[#emoji.heart.purple#{}3] Now,
  $
    abs(c a_n - c a) = abs(c) abs(a_n - a).
  $
  #note[#emoji.heart.purple#{}4] We are given that $(a_n) -> a$, so we know we can make $abs(a_n - a)$ as small as we like.
  #note[#emoji.heart.purple#{}5] In particular, we can choose an $N in NN$ such that
  $
    abs(a_n - a) < epsilon / abs(c).
  $
  whenever $n >= N$.
  #note[#emoji.heart.purple#{}6] To see that this $N$ indeed works, observe that, for all $n >= N$,
  $
    abs(c a_n - c a) = abs(c) abs(a_n - a) < abs(c) epsilon/abs(c) = epsilon.
  $
  #note[#emoji.heart.purple#{}1] The case $c = 0$ reduces to showing that the constant sequence $(0, 0, 0, ...)$ converges to $0$, which is trivial.
]

#appreciation[
  #note[#emoji.heart.purple#{}1:] Perfect example of how to write a proof by cases.
  Note that there are two #note[#emoji.heart.purple#{}1] markers.

  #note[#emoji.heart.purple#{}2:] Love the reassertion of the goal after fixing $epsilon$.
  While "find some point in the sequence after which..." is not the mathematical way to describe the goal, but it is perfectly acceptable here because reassertion of the goal is already optional.

  #note[#emoji.heart.purple#{}3 and #emoji.heart.purple#{}4:] These two sentences are part of the thinking process in the second step of how we choose $N$.
  We would still have a good proof without them, but Abbott has to include them because he is writing to explain not just to prove.
  However, it is undeniable that they added clarity and *value* to the proof, so it is not a bad idea to include them in our writings as well.
  These kind of explanatory comments is lacking in many other sources, and we are extremely lucky to have Abbott's textbook.

  #note[#emoji.heart.purple#{}5:] The "in particular" is reminding us of $(a_n) -> a$ in the flavor text #note[#emoji.heart.purple#{}4].
  It makes #note[#emoji.heart.purple#{}4] blend into the formal proof seamlessly.
  We can also write "Because $(a_n) -> a$, we can choose an $N in NN$ such that...," but this is so dry in comparison.
  The phrase "we can choose...such that..." is a good keyword to introduce variables.

  #note[#emoji.heart.purple#{}6:] The phrase "To see that this $N$ indeed works directly our attention to the verification step.
  In general, "to see that..." is a good way to bring attention to a goal or subgoal that will be proven next.
]

= Algebraic Limit Theorem

The algebraic limit theorem states that if $lim a_n = a in RR$ and $lim b_n = b in RR$, then
#set enum(numbering: "(i)")
+ $lim (c a_n) = c a$ for all $c in RR$;
+ $lim (a_n + b_n) = a + b$;
+ $lim (a_n b_n) = a b$; and
+ $lim (a_n \/ b_n) = a \/ b$, provided that $b != 0$.

#remark[
  Note that $a_n \/ b_n$ might not be defined for all $n$.
  However, if $b != 0$, there will be some $M in NN$ such that $b_n != 0$ for all $n >= M$ (why?).
  Thus, $a_n \/ b_n$ will be _eventually_ defined, and limit would still make sense:
  #align(center)[
    A sequence $(a_n)_(n = M)^(oo)$ with starting index $M in NN$ is said to converge to $a$ if for every $epsilon > 0$, there exists $N >= M$ such that for all $n >= N$, we have $abs(a_n - a) < epsilon$.
  ]
]

Note that it is important to make sure that the limits of $(a_n)$ and $(b_n)$ exist before applying the algebraic limit theorem.
If we naively write
$
  lim ((-1)^(n) + (-1)^(n + 1)) = lim (-1)^(n) + lim (-1)^(n + 1) = "DNE",
$
we may wrongly conclude that the limit of $((-1)^(n) + (-1)^(n + 1))$ does not exist, when in fact, it is just the constant sequence $(0, 0, 0, ...)$ whose limit is $0$.
The problem here is that the limits of $(-1)^(n)$ and $(-1)^(n + 1)$ do not exist, so we cannot apply the algebraic limit theorem.

#exercise[
  For each condition below, give an example of sequences $(a_n)$ and $(b_n)$ satisfying the condition or show why the request is impossible.
  #set enum(numbering: "(a)")
  + $lim b_n = 0$ and $lim (a_n b_n) != 0$.
  + $(a_n)$ is bounded, $lim b_n = 0$, and $lim (a_n b_n) != 0$.
]
#proof[
  + Let $a_n = n$ and $b_n = 1/n$ for all $n in NN$.
    Then, we have $lim b_n = 0$ and $a_n b_n = 1$ for all $n in NN$, so $lim (a_n b_n) = 1 != 0$.
  + This is impossible.
    If $(a_n)$ is bounded and $lim b_n = 0$, then we claim that $lim (a_n b_n) = 0$.
    We cannot directly apply the algebraic limit theorem because the limit of $(a_n)$ might not exist.
    However, since $(a_n)$ is bounded, there exists some $M > 0$ such that $abs(a_n) <= M$ for all $n in NN$.
    Let $epsilon > 0$ be arbitrary.
    Observe that
    $
      abs(a_n b_n - 0) = abs(a_n) abs(b_n) <= M abs(b_n).
    $
    We know $lim b_n = 0$, so we can make $abs(b_n)$ as small as we like.
    Notably, we can find some $N in NN$ such that $abs(b_n) < epsilon / M$ whenever $n >= N$.
    Therefore, for all $n >= N$, we have
    $
      abs(a_n b_n - 0) <= M abs(b_n) < M (epsilon / M) = epsilon.
    $
    Since for arbitrary $epsilon > 0$, we have found some working $N in NN$, we conclude that $lim (a_n b_n) = 0$.
]