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
  h(1fr)
  qed
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
  title: "MAT 127A Discussion 3 Notes",
  author: "Chen Liang",
  date: "October 14, 2025",
)

#let subset = symbol(
  "⊆",
  ("simple", "⊂"),
  ("not", "⊈")
)
#let supset = symbol(
  "⊇",
  ("simple", "⊃"),
  ("not", "⊉")
)

#let warning = box(
  baseline: 2pt,
  canvas({
    import cetz.draw: *
    circle((0, 0), radius: 0.5em, fill: yellow, stroke: none)
    content((0,0))[*!*]
  })
)

= Review and Warm-Up

#exercise[
  Complete the table, make the equivalent characterizations as "useful" as possible.

  #table(
    columns: (1fr, 2.5fr),
    inset: (top: 6pt, bottom: 9pt),
    table.header([*Compact expression*], [*Equivalent characterization*]),

    table.cell(colspan: 2)[#text(dark-magenta)[(Examples)]],

    $x in f^(-1)(B)$,
    [$f(x) in B$.],

    [$f$ if not injective],
    [There exist $x_1 != x_2$ such that $f(x_1) = f(x_2)$.],

    table.cell(colspan: 2)[#text(dark-magenta)[(Review)]],

    $A subset.not B$,
    [There exists an $x in A$ such that $x in.not B$.],

    $x in.not f(A)$,
    [For all $a in A$, we have $f(a) != x$.],

    $x in.not inter.big_(n=1)^(oo) J_n$,
    [There exists an $n$ such that $x in.not J_n$.],

    table.cell(colspan: 2)[#text(dark-magenta)[(Least upper bound)]],

    $sup A <= x$,
    [$x$ is an upper bound of $A$.],

    $sup A < x$,
    [There exists an $epsilon > 0$ such that $x - epsilon$ is an upper bound of $A$.],

    $sup A > x$,
    [There exists an element $a in A$ such that $x < a$.],

    $sup A >= x$,
    [For all $epsilon > 0$, there exists an element $a in A$ such that $x - epsilon < a$. #warning],
  )
]
#warning You may not use this characterization for $sup A >= x$ without proof in homework and exam because it is not a theorem in the textbook or lectures.
However, you can use it in conjunction with $sup A <= x$ to argue that
#align(center)[
  #show: it => block(inset: (left: 1in, right: 1in), it)
  $sup A = x$ if and only if $x$ is an upper bound of $A$ and\
  for all $epsilon > 0$, there exists an element $a in A$ such that $x - epsilon < a$.
]
This is Lemma 1.3.8 in the textbook, and it is a *very important* equivalent characterization of least upper bound that is useful in both computation and proofs (just try to prove that $1 = sup (0, 1)$).

One way to think about this characterization is that it is saying $sup A$ is on the "boundary of $A$" in the sense that $sup A - epsilon$ would "fall into the territory of $A$" in the sense that there exists some element in $A$ that is greater than $sup A - epsilon$.
// I personally like to call it the "limit upper bound" because it is reminiscent of the definition of limit ("for every $epsilon > 0$, there exists something that makes something near something within $epsilon$").

#remark[
  Also you cannot use any of the equivalent characterizations when the problem is literally asking you to prove them.
  In general, whether or not you can use a theorem in a problem depends on whether the it is the "meat of the problem".
  If the problem is testing you whether you know the proof of the theorem, then you cannot just say someone else has proven it.
]

// Some other equivalent characterizations

= Least Upper Bound

#exercise[
  Let $A$ and $B$ be nonempty bounded subsets of $RR$ and $A + B = {a + b | a in A "and" b in B}$.
  Show that $sup (A + B) = sup A + sup B$.
]
#proof[
  To show that $sup A + sup B$ is the supremum of $A + B$, it suffices to show two things:
  + $sup A + sup B$ is an upper bound of $A + B$.
  + For all $epsilon > 0$, there exists an element in $A + B$ that is greater than $sup A + sup B - epsilon$.

  #remark[
    These two are equivalent to $sup (A + B) <= sup A + sup B$ and $sup (A + B) >= sup A + sup B$ respectively.
    However, as mentioned before, we should not mention this because the characterization of the latter is not a theorem in the textbook or lectures.
  ]

  Fix arbitrary $x in A + B$, then we can write $x = a + b$ for some $a in A$ and $b in B$.
  Since $a <= sup A$ and $b <= sup B$ because $sup A$ and $sup B$ are upper bounds of $A$ and $B$ respectively, we have
  $
    x = a + b <= sup A + sup B.
  $
  Therefore, $sup A + sup B$ is indeed an upper bound of $A + B$, and we are done with the first part.

  Now, fix arbitrary $epsilon > 0$, we want to find $a in A$ and $b in B$ such that $a + b > sup A + sup B - epsilon$.
  The core idea to find $a in A$ and $b in B$ separately such that $a > sup A - epsilon/2$ and $b > sup B - epsilon/2$.
  Because $sup A - epsilon / 2$ is not an upper bound for $A$, there indeed exists some $a in A$ such that $a > sup A - epsilon/2$.
  #remark[
    This can also be seen from the equivalent characterization of $sup A > sup A - epsilon/2$.
  ]
  Similarly, there indeed exists some $b in B$ such that $b > sup B - epsilon/2$.
  Therefore, we have
  $
    a + b > (sup A - epsilon/2) + (sup B - epsilon/2) = sup A + sup B - epsilon.
  $
  This completes the proof.
]

This technique of breaking $epsilon$ into two pieces is very common in analysis.
We will see it again to prove things about sums such as
- $lim_(n -> oo) (a_n + b_n) = lim_(n -> oo) a_n + lim_(n -> oo) b_n$,
- $(f + g)' = f' + g'$,
- $integral_a^b (f(x) + g(x)) dif x = integral_a^b f(x) dif x + integral_a^b g(x) dif x$.
We can also generalize this technique to break $epsilon$ into countably many pieces:
$
  epsilon = epsilon/2 + epsilon/4 + epsilon/8 + ....
$

= Archimedean Properties

There are two Archimedean properties: one for big numbers and one for small numbers.
+ (Big) For all $x in RR$, there exists some $n in NN$ such that $n > x$.
+ (Small) For all $epsilon > 0$, there exists some $n in NN$ such that $1/n < epsilon$.
The entire point of the following exercises is to test you whether you know the two Archimedean properties.

#exercise[
  #set enum(spacing: 1.5em)

  #text(dark-magenta)[(From exercise 1.4.8 solution)]
  + Let $L_n = [n, oo)$, show that $inter.big_(n=1)^(oo) L_n = emptyset$.
  + Let $J_n = (-1/n, 1/n)$, show that $inter.big_(n=1)^(oo) J_n = {0}$.
]
#proof[
  + Fix arbitrary $x in RR$, we know by the Archimedean property that there exists some $n in NN$ such that $n > x$.
    Therefore, we have $x in.not L_n$, and so $x in.not inter.big_(n=1)^(oo) L_n$.
    Thus no real number can be in the intersection, that is $inter.big_(n=1)^(oo) L_n = emptyset$.

  + It is clear that ${0} subset inter.big_(n=1)^(oo) J_n$ because $0 in J_n$ for all $n$.
    Now, we want to show that $inter.big_(n=1)^(oo) J_n subset {0}$.
    Fix arbitrary $x in inter.big_(n=1)^(oo) J_n$, then we consider the following cases.
    - If $x > 0$, then by the Archimedean property, there exists some $n in NN$ such that $1/n < x$.
      Therefore, we have $x in.not J_n$, which contradicts the assumption that $x in inter.big_(n=1)^(oo) J_n$.
    - If $x < 0$, then by the Archimedean property, there exists some $n in NN$ such that $1/n < -x$, and so $-1/n > x$.
      Therefore, we have $x in.not J_n$, which again contradicts the assumption that $x in inter.big_(n=1)^(oo) J_n$.
    Thus, we must have $x = 0$, and so $inter.big_(n=1)^(oo) J_n subset {0}$.
    This completes the proof.
]