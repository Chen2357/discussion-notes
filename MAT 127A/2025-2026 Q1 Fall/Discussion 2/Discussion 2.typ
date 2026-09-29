#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"

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
  title: "MAT 127A Discussion 2 Notes",
  author: "Chen Liang",
  date: "October 7, 2025",
)

#let subset = symbol(
  "⊆",
  ("simple", "⊂"),
)
#let supset = symbol(
  "⊇",
  ("simple", "⊃"),
)

#let two-column-enum(body) = context {
  let items = body
    .children
    .filter(x => x.func() == enum.item)
    .enumerate()
    .map(((i, x)) => [#numbering(enum.numbering, i + 1) #x.body])
  set raw(lang: "r")
  grid(columns: (1fr, 1fr), column-gutter: 1.65em, row-gutter: par.leading, ..items)
}

= Image and Preimage

Recall that the #define[image] of a subset $A subset X$ under a function $f: X -> Y$ is defined as
$
  f(A) = {y in Y | y = f(x) "for some" x in A}.
$
When we see set builder notation like this, we should automatically generate this proposition:
$
  y in f(A) "if and only if" y = f(x) "for some" x in A.
$
#remark[
  This is the proposition that we should use when writing proofs, and the intermediate step that
  #align(center)[
    $y in f(A)$ means $y in {z in Y | z = f(x) "for some" x in A}$,\
    which means $y = f(x) "for some" x in A$
  ]
  should be skipped to reduce our mental load.
]

The #define[preimage] of a subset $C subset Y$ under a function $f: X -> Y$ is defined as
$
  f^(-1) (C) = {x in X | f(x) in C}.
$
Again, we should automatically generate this proposition:
$
  x in f^(-1) (C) "if and only if" f(x) in C.
$

#exercise[
  Decide (no need to prove) whether each of the following statements is always true for a general function $f: X -> Y$ and subsets $A, B subset X$ and $C, D subset Y$.
  If not, demonstrate a counterexample.

  #set enum(numbering: "(1) ")
  #two-column-enum[
    + $f(A union B) = f(A) union f(B)$
    + $f(emptyset) = emptyset$

    + $f(A inter B) = f(A) inter f(B)$
    + $f(X) = Y$

    + $f^(-1) (C union D) = f^(-1) (C) union f^(-1) (D)$
    + $f^(-1) (emptyset) = emptyset$

    + $f^(-1) (C inter D) = f^(-1) (C) inter f^(-1) (D)$
    + $f^(-1) (Y) = X$
  ]
]
#proof(label: "Solution")[
  (1, 2, 5, 6, 7, 8) are always true.
  - (3) is not always true.
    As a concrete example, consider $X = {1, 2, 3}$ and $Y = {1, 2}$ with $f(1) = 1$, $f(2) = 2$, and $f(3) = 1$.
    #align(center, {
      cetz.canvas({
        import cetz.draw: *

        let x = 1.5
        let s = 0.75

        circle((-x, 0.5 * s), radius: (0.4, s), fill: blue.transparentize(50%), stroke: none)
        circle((-x, -0.5 * s), radius: (0.4, s), fill: purple.transparentize(50%), stroke: none)

        content((-x, s))[$3$]
        content((-x, 0))[$2$]
        content((-x, -s))[$1$]

        content((x, 0.5 * s))[$2$]
        content((x, -0.5 * s))[$1$]

        line((-x + 0.4, s), (x - 0.2, -0.5 * s), mark: (end: "straight"))
        line((-x + 0.4, 0), (x - 0.2, 0.5 * s), mark: (end: "straight"))
        line((-x + 0.4, -s), (x - 0.2, -0.5 * s), mark: (end: "straight"))
      })
    })
    Then,
    $
      f({1, 2} inter {2, 3}) = f({1}) = {1},
    $
    but
    $
      f({1, 2}) inter f({2, 3}) = {1, 2} inter {1, 2} = {1, 2}.
    $
    The key to this example are the elements $1$ and $3$ which do not lie in ${1, 2} inter {2, 3}$, but $f$ maps both of them to $1$ --- information that is lost if we take the intersection first.
  - (4) is true if and only if $f$ is surjective.
    Any non-surjective function is a counterexample.
]

#remark[
  The facts that image does not necessarily preserve binary intersection and the full subset (a.k.a. improper subset) are segments of the catchphrase that "image does not play well with intersection."
  The relationship between the full subset and the intersection operation is that
  #align(center)[
    the full subset is the identity for intersection,
  ]
  meaning that $A inter X = X inter A = A$.
  This is completely analogous to how $0$ is the identity for addition because $a + 0 = 0 + a = a$, and $1$ is the identity for multiplication because $a dot 1 = 1 dot a = a$.
  Similarly, we can say that the empty set is the identity for union.
  This is the reason why I placed empty set next to union in the same rows, and full set next to intersection in the same rows.
]

// Vote on which one to talk about?

= Cardinality

Recall that a set $X$ is #define[finite] if
$
  X approx {1, 2, ..., n} "for some" n in NN "or" X = emptyset.
$
The $approx$ relation here means that there exists a bijection between the two sets.

A set $X$ is #define[infinite] if it is not finite.
A useful alternative characterization is that there exists a sequence of distinct elements $x_1, x_2, ... in X$.

A set $X$ is #define[countable] if $X approx NN$ or that $X$ is finite.
A useful alternative characterization is that $X$ is countable if and only if $X$ is empty or that there exists a surjection from $NN$ to $X$.
#remark[
  Yet, another useful characterization is that $X$ is countable if and only if there exists an injection from $X$ to $NN$, but we wouldn't be using this in this discussion.
]

Since a function from $NN$ to $X$ is just a sequence, we can leverage this to build intuition about countable sets.
If $X$ is nonempty, then it is countable if and only if there exists a sequence $x_1, x_2, ... in X$ such that $X = {x_1, x_2, ...}$.
We can see the function $x_(bullet)$ as a function $NN -> X$.

#exercise[
  #text(dark-magenta)[(Lecture 10.03.25)]
  #set enum(numbering: "(a) ")
  Let $X$ be a set, and let $A_1, A_2, ...$ be a sequence of nonempty countable subsets of $X$.

  + Show that $A_1 union A_2$ is countable.\
    _Hint: Write $A_1 = {x_1, x_2, ...}$ and $A_2 = {y_1, y_2, ...}$, can we write down a sequence $z_1, z_2, ... in A_1 union A_2$ such that $A_1 union A_2 = {z_1, z_2, ...}$?_

  + Show that $union.big_(i=1)^oo A_i$ is countable.\
    _You may directly use the fact that $NN approx NN times NN$ if you can describe a construction of the bijection but you do not need to prove that it is one._
]
#proof[
  #set enum(numbering: "(a) ")
  + Since $A_1$ and $A_2$ are nonempty and countable, we can write them as $
      A_1 = {x_1, x_2, ...} "and" A_2 = {y_1, y_2, ...}.
    $
    It suffices to show that there exists a sequence $z_1, z_2, ... in A_1 union A_2$ such that $A_1 union A_2 = {z_1, z_2, ...}$.
    The idea is to write
    $
      A_1 union A_2 = {x_1, y_1, x_2, y_2, x_3, y_3, ...}.
    $
    Through pattern matching, we see that we can define such a sequence by
    $
      z_(2n - 1) = x_n "and" z_(2n) = y_n "for all" n in NN.
    $
    It remains to show that $A_1 union A_2 = {z_1, z_2, ...}$.
    Fix an arbitrary $a in A_1 union A_2$, we wish to show that $a = z_n$ for some $n in NN$.
    By the definition of union, we have $a in A_1$ or $a in A_2$.
    - If $a in A_1$, then $a = x_n$ for some $n in NN$.
      Thus, $a = z_(2n - 1)$.
    - If $a in A_2$, then $a = y_n$ for some $n in NN$.
      Thus, $a = z_(2n)$.
    This shows that $A_1 union A_2 = {z_1, z_2, ...}$.
    #remark[
      Really, this just shows that $A_1 union A_2 subset {z_1, z_2, ...}$, but the other direction is trivial since $z_1, z_2, ...$ is a sequence in $A_1 union A_2$.
    ]

    *As an alternative solution*, we can also deploy the language of functions as opposed to sequences.
    Since $A_1$ and $A_2$ are nonempty and countable, there exist surjections $f: NN -> A_1$ and $g: NN -> A_2$.
    It suffices to show that there exists a surjection $h: NN -> A_1 union A_2$.
    Like what we did for sequences, the idea is to define
    $
      h(2n - 1) = f(n) "and" h(2n) = g(n) "for all" n in NN.
    $
    To show that this is a surjection, fix an arbitrary $a in A_1 union A_2$, we wish to show that $a = h(n)$ for some $n in NN$.
    By the definition of union, we have $a in A_1$ or $a in A_2$.
    - If $a in A_1$, then $a = f(n)$ for some $n in NN$.
      Thus, $a = h(2n - 1)$.
    - If $a in A_2$, then $a = g(n)$ for some $n in NN$.
      Thus, $a = h(2n)$.
    This shows that $h$ is a surjection.
    #remark[
      You see, this is the exact same proof written differently under the correspondences $f <-> x_bullet$, $g <-> y_bullet$, and $h <-> z_bullet$.
    ]
    // Since $A_1$ and $A_2$ are countable, there exists surjections $g_1: NN -> A_1$ and $g_2: NN -> A_2$.
    // Together, they form the surjection $g: {1, 2} times NN -> A_1 union A_2$ given by
    // $
    //   g(i, n) = g_i (n).
    // $
    // The key step in this proof is to note that there is a bijection $h: NN -> NN approx {1, 2}$.
    // #align(center, grid(
    //   columns: (1fr, 2fr),
    //   cetz.canvas({
    //     import cetz.draw: *

    //     let x = 0.4
    //     let s = 0.8
    //     let N = 5

    //     for i in range(N) {
    //       circle((-x, i * s), radius: 0.1, fill: blue, stroke: none)
    //       content((), anchor: "east", padding: (right: 0.3))[$(1, #{i+1})$]

    //       circle((x, i * s), radius: 0.1, fill: red, stroke: none)
    //       content((), anchor: "west", padding: (left: 0.3))[$(2, #{i+1})$]

    //       line((-x + 0.1, i * s), (x - 0.1, i * s), mark: (end: "straight"))
    //       line((x - 0.1, i * s + 0.1), (-x + 0.1, (i + 1) * s - 0.1), mark: (end: "straight"))
    //     }
    //     content((-x, s * N))[$dots.v$]
    //     content((x, s * N))[$dots.v$]

    //     content((0, -s))[${1, 2} times NN$]
    //   }),
    //   align(horizon, cetz.canvas({
    //     import cetz.draw: *

    //     let y = 1
    //     let s = 1.2
    //     let N = 8

    //     content((N / 2 * s, y + 1))[$NN$]

    //     for i in range(N) {
    //       let color = if calc.rem-euclid(i, 2) == 0 { blue } else { red }

    //       content((s * i, y))[$#{i + 1}$]
    //       content((s * i, -y))[#text(color)[$(#{calc.rem-euclid(i, 2) + 1}, #{calc.div-euclid(i, 2) + 1})$]]
    //       line((s * i, y - 0.3), (s * i, -y + 0.3), mark: (end: "straight"))
    //     }

    //     content((s * N, y))[$dots.c$]
    //     content((s * N, -y))[$dots.c$]

    //     content((N / 2 * s, -y - 1))[${1, 2} times NN$]
    //   })),
    // ))
    // This is similar to the last exercise in Discussion 1 where we have to prove $ZZ approx NN$ (you see, $ZZ$ is like two copies of $NN$ with an added $0$).
    // Explicitly, we can define $h$ by defining it on the odd and even numbers separately:
    // $
    //   h(2n + 1) = (1, n) "and" h(2n) = (2, n).
    // $
    // The proof that $h$ is a bijection will follow a similar style as the last exercise in Discussion 1, and we will omit here.
    // Finally, we can define $f = g compose h$ which is a surjection from $NN$ to $A_1 union A_2$ (since $h$ just relabels the elements and $g$ is surjection, the composition is still a surjection; more generally, any composition of surjections is a surjection).

  + If we use $x_bullet$ for $A_1$, $y_bullet$ for $A_2$, and $z_bullet$ for $A_3$, and so on, we will run out of letters (some may say we already ran out of letters).
    Instead, we have to use indices.
    Since $A_i$ is nonempty and countable for each $i in NN$, we can write
    $
      A_i = {x_((i, 1)), x_((i, 2)), ...} "for all" i in NN.
    $
    The question is how to find a sequence $z_1, z_2, ... in union.big_(i=1)^oo A_i$ that goes through the grid of elements $x_((i, j))$ over $(i, j) in NN times NN$.
    This is where the fact that $NN approx NN times NN$ comes in handy.
    It tells us that there is a bijection $h: NN -> NN times NN$, and we can simply define
    $
      z_n = x_(h(n)).
    $
    We indeed have $union.big_(i=1)^oo A_i = {z_1, z_2, ...}$ because for any arbitrary $a in union.big_(i=1)^oo A_i$, we have $a in A_i$ for some $i in NN$, which tells us that $a = x_((i, j))$ for some $j in NN$.
    Since $h$ is a surjection, there exists some $n in NN$ such that $h(n) = (i, j)$, and therefore $a = x_((i, j)) = x_(h(n)) = z_n$.

    // It suffices to show that there exists a surjection $f: NN -> union.big_(i=1)^oo A_i$.
    // Since each $A_i$ is countable, there exists surjections $g_i: NN -> A_i$ for each $i in NN$.
    // Together, they form the surjection $g: NN times NN -> union.big_(i=1)^oo A_i$ given by
    // $
    //   g(i, n) = g_i (n).
    // $
    // By the fact that $NN approx NN times NN$, there exists a bijection $h: NN -> NN times NN$.
    // Thus, we can define $f = g compose h$ which is a surjection from $NN$ to $union.big_(i=1)^oo A_i$.
    A construction of $h$ can be described by first breaking down $NN times NN$ into subsets whose elements sum to the same value:
    $
      D_2 &= {(1, 1)}, \
      D_3 &= {(1, 2), (2, 1)}, \
      D_4 &= {(1, 3), (2, 2), (3, 1)}, \
      D_5 &= {(1, 4), (2, 3), (3, 2), (4, 1)}, \
      &#h(0.3em) dots.v \
      D_n &= {(1, n-1), (2, n-2), ..., (n-1, 1)}, \
      &#h(0.3em) dots.v
    $
    Then, simply enumerate the elements in $D_2$, $D_3$, $D_4$, ... in that order will yield a bijection from $NN$ to $NN times NN$.

    #remark[
      I called them $D_n$ because they look like the diagonals in the $NN times NN$ grid.
      In the lecture, they are literally referred to as diagonals.
    ]

    #remark(label: "Additional exercise")[
      It is your turn to write a proof based on functions instead of sequences!
    ]
]

#exercise[
  #text(dark-magenta)[(Case study: why countability matters in real analysis?)]
  Let $A$ be a set consists of positive real numbers.
  We say $A$ is #define[summable] if there exists an upper bound on the sums of finite subsets of $A$, _i.e._, there exists some $M in RR$ such that for every finite subset ${a_1, ..., a_n} subset A$, we have $a_1 + ... + a_n <= M$. _(The least upper bound is the sum of $A$, but this is not important here.)_

  #set enum(numbering: "(a) ")
  + Find an infinite summable set of positive real numbers.
  + Show that if a set $A$ of positive real numbers is summable, then $A$ is countable.
]
#proof[
  #set enum(numbering: "(a) ")
  + $A = {1/2, 1/4, 1/8, 1/16, 1/32, ...}$ is summable.
    To see this, consider an arbitrary finite subset ${a_1, a_2, ..., a_n} subset A$, and without loss of generality, assume we write them in descending order, _i.e._, $a_1 > a_2 > ... > a_n$.
    Then, we must have
    $
      a_1 <= 1/2, quad a_2 <= 1/4, quad ..., quad a_n <= 1/2^n.
    $
    Therefore, by the geometric sum, we have
    $
      a_1 + a_2 + dots.c + a_n <= 1/2 + 1/4 + dots.c + 1/2^n = 1 - 1/2^n < 1.
    $
    Thus, $A$ is summable with $M = 1$. (In fact, the sum of $A$ is $1$.)
  + Note that we can break $A$ into countably many subsets:
    $
      A_1 &= A inter [1/2, oo), \
      A_2 &= A inter [1/4, 1/2), \
      A_3 &= A inter [1/8, 1/4), \
      A_4 &= A inter [1/16, 1/8), \
      &#h(0.3em) dots.v \
      A_n &= A inter [1/2^n, 1/2^(n-1)), \
      &#h(0.3em) dots.v
    $
    Since $A$ is summable, let us say it is summable with an upper bound $M$, then $A_n$ must be summable by the same upper bound.
    This implies that each $A_n$ is finite because otherwise, we could find a sequence of distinct elements $a_1, a_2, ... in A_n$, but then $a_i >= 1/2^n$ implies that
    $
      a_1 + a_2 + dots.c + a_k >= k / 2^n
    $
    which can be made arbitrarily large, contradicting the summability of $A_n$ (we have $a_1 + dots.c + a_k > M$ when $k > 2^n M$).
    Thus, $A = union.big_(n=1)^(oo) A_n$ is a union of countably many finite sets, and therefore countable by the previous exercise (or by enumerating the elements in the order $A_1$, $A_2$, $A_3$, ...).

    #remark[
      Defining $A_n = A inter [1/2^n, oo)$ uniformly (as opposed to making $A_1$ an exception) also works.
      We do not need the $A_n$'s to be disjoint.
    ]
]
