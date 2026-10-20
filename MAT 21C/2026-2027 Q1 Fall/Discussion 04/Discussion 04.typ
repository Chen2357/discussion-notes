#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#let dd = physica.dd.with(d: $d$)

#set document(
  title: "Discussion 4 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 10, day: 20),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Parallelogram solution.svg" : "32222846",
    "Parallelogram.svg" : "32222847",
    "River mirror.svg" : "32222848",
    "River string.svg" : "32222849",
    "River.svg" : "32222850",
    "Taylor series bait.svg" : "32222851",
    "Upper bound.svg" : "32232192",
    "Vector addition.svg" : "32222854",
    "Vector scaling.svg" : "32222855",
    "Vector subtraction.svg" : "32222856",
    "Vector.svg" : "32222857",
  ),
)

#show columns: it => {
  if target() == "html" {
    return it.body
  } else {
    it
  }
}

#context if target() == "html" {
  outline()
}

= Taylor's Formula

Taylor series are unreasonably effective at being _equal_ to the original function!
Consider a function $f(x)$ that looks just like the function $x$ on the interval $[-1, 1]$.
We have
$
  f(0) = 0, quad f'(0) = 1, quad f''(0) = 0, quad f^((3)) (0) = 0, quad dots.c,
$
so the Taylor series of $f(x)$ at $x = 0$ is just
$
  f(0) + f'(0) x + f''(0) x^2 / 2! + f^((3)) (0) x^3 / 3! + dots.c = x.
$
However, there is nothing preventing me from defining $f(x)$ to be something completely different from $x$ outside of the interval $[-1, 1]$, then the Taylor series would be totally off despite being convergent for all $x$.
#figure(
  image(
    "Taylor series bait.svg",
    width: 50%,
    alt: "A graph of a function that looks exactly like y = x on an interval around 0, but is different outside of that interval.",
  ),
  caption: [
    The function in red $f(x) = x ( 1 - e^(-1\/x^2) )$ has the Taylor series $x$ (in blue). Despite the Taylor series being convergent for all $x$, it fails to even approximate $f(x)$.
  ]
)
It is magical that for many functions we are interested in, the Taylor series whenever is convergent, converges to the original function.
Taylor's formula tells us the condition for when a function has this nice property.

#theorem(label: [Taylor's Formula])[
  The remainder term
  $
    R_n (x) = f(x) - ( f(0) + f'(0) x + f''(0) x^2 / 2! + dots.c + f^((n)) (0) x^n / n! )
  $
  after approximating $f(x)$ by the Taylor polynomial of degree $n$ is bounded by
  $
    abs(R_n (x)) <= M abs(x)^(n+1) / (n+1)!
  $
  where $M$ is an upper bound for $abs(f^((n+1))(c))$ for all $c$ between $0$ and $x$.
  #figure(
    image(
      "Upper bound.svg",
      width: 40%,
      alt: "A graph of a decreasing function on the interval 0 to x. A dashed horizontal line is drawn to be above the function, the the line is labeled M.",
    ),
    caption: [
      Choose $M$ so that the line $y = M$ is above the graph of $y = abs(f^((n+1))(c))$ on the interval between $0$ and $x$.
    ]
  )

  If we can show that
  $
    lim_(n -> oo) abs(R_n (x)) <= lim_(n -> oo) M abs(x)^(n+1) / (n+1)! = 0,
  $
  then we can conclude that the equality
  $
    f(x) = f(0) + f'(0) x + f''(0) x^2 / 2! + f^((3)) (0) x^3 / 3! + dots.c,
  $
  finally establishing the relationship between the function and its Taylor series.
  Be careful that $M$ is not always a constant, it can depend on $n$ and $x$, so the limit $lim_(n -> oo) M abs(x)^(n+1) / (n+1)!$ might not be zero.
]

As an example, the Taylor series of $f(x) = e^x$ is
$
  1 + x + x^2 / 2! + x^3 / 3! + x^4 / 4! + dots.c.
$
The exercise last week was using ratio test to show that this series converges for all $x$, but does it really converge to $e^x$?

Let us say we want to show that the series converges to $e^7$ at $x = 7$.
We can write down the remainder
$
  R_n (7) = e^7 - (1 + 7 + 7^2 / 2! + 7^3 / 3! + dots.c + 7^n / n!)
$
which is bounded by
$
  abs(R_n (7)) <= M 7^(n+1) / (n+1)! .
$
We can choose $M = e^7$ since that is the maximum value of $abs(f^((n+1))(c))$ on the interval between $0$ and $x = 7$.
Therefore, we have
$
  abs(R_n (7)) <= e^7 7^(n+1) / (n+1)! .
$
#tip[
  This inequality is of interest on its own.
  It tells us how good our approximation of $e^7$ is using just the first $n$ terms of the Taylor series.
  For example, it tells us that the difference between $e^7$ and
  $
    1 + 7 + 7^2 / 2! + 7^3 / 3! + dots.c + 7^40 / 40!
  $
  is at most
  $
    e^7 7^41 / 41! lt.tilde 1.462 times 10^(-12).
  $
  This tells us that the approximation is accurate to 12 decimal places!
]
To show that
$
  1 + 7 + 7^2 / 2! + 7^3 / 3! + dots.c = e^7
$
amounts to showing that
$
  lim_(n -> oo) abs(R_n (7)) <= lim_(n -> oo) e^7 7^(n+1) / (n+1)! = 0
$
which is true because $lim_(n -> oo) x^n \/ n! = 0$ for all $x$ (which is on our formula sheet).

#exercise[
  + Show that
    $
      1 + 9 + 9^2 / 2! + 9^3 / 3! + dots.c = e^9.
    $
    _(The solution is simply replacing $7$ with $9$ in the example.)_
  + Show that the Taylor series of $e^x$ converges to $e^x$ for all $x > 0$.
  + Show that the Taylor series of $e^x$ converges to $e^x$ for all $x < 0$.
]
#solution[
  + The remainder at $x = 9$ is
    $
      R_(n) (9) = e^(9) - (1 + 9 + frac(9^(2), 2 !) + frac(9^(3), 3 !) + dots.h.c+ frac(9^(n), n !))
    $
    which is bounded by
    $
         abs(R_(n)(9)) <= M frac(9^(n + 1), (n + 1)!)
    $
    We can choose $M = e^(9)$ since that is the maximum value of $abs(f^((n + 1))(c))$ on the interval between $0$ and $x = 9$.
    Therefore, we have
    $
      lim_(n -> infinity) abs(R_(n)(9)) <= lim_(n -> infinity) e^(9) frac(9^(n + 1), (n + 1)!)  = 0,
    $
    and we can conclude that the Taylor series converges to $e^(9)$ at $x = 9$.
  + For $x > 0$, the remainder at $x$ is
    $
      R_(n) (x) = e^(x) - (1 + x + frac(x^(2), 2 !) + frac(x^(3), 3 !) + dots.h.c+ frac(x^(n), n !))
    $
    which is bounded by
    $
      abs(R_(n)(x)) <= M frac(x^(n + 1), (n + 1)!) .
    $
    We can choose $M = e^(x)$ since that is the maximum value of $abs(f^((n + 1))(c))$ on the interval between $0$ and $x$.
    Therefore, we have
    $
      lim_(n -> infinity) abs(R_(n)(x)) <= lim_(n -> infinity) e^(x) frac(x^(n + 1), (n + 1)!) = 0,
    $
    and we can conclude that the Taylor series converges to $e^(x)$ for all $x > 0$.
  + For $x < 0$, the remainder at $x$ is
    $
      R_(n) (x) = e^(x) - (1 + x + frac(x^(2), 2 !) + frac(x^(3), 3 !) + dots.h.c + frac(x^(n), n !))
    $
    which is bounded by
    $
      abs(R_(n)(x)) <= M frac(abs(x)^(n + 1), (n + 1)!) .
    $
    We can choose $M = e^(0) = 1$ since that is the maximum value of $abs(f^((n + 1))(c))$ on the interval between $x$ and $0$ (note that $x$ is negative).
    Therefore, we have
    $
      lim_(n -> infinity) abs(R_(n)(x)) <= lim_(n -> infinity) frac(abs(x)^(n + 1), (n + 1)!) = 0,
    $
    and we can conclude that the Taylor series converges to $e^(x)$ for all $x < 0$.
]

= Warm-Up

#exercise(label: [Warm-Up])[
  A traveler wants to get from Town 1 to Town 2 as shown in the figure below, but they must stop by a river along the way.
  What is the the shortest path they can take? (The optimal path is one of the four options A, B, C, or D.)
  #figure(
    image(
      "River.svg",
      width: 50%,
      alt: "Options A to D listed left to right on the river. Town 1 is closer to the river than Town 2. Options A and D are directly below Towns 1 and 2 respectively. Option B is closer to Town 1.",
    ),
  )
]
#solution[
  Imagine that there is a mirror image of Town 1 on the other side of the river.
  Each path from the mirror image to Town 2 corresponds to a path equal in length from Town 1 to Town 2 that passes through the river.
  Therefore, the shortest path should correspond to the straight line from the mirror image to Town 2.
  In particular, it is the path such that the angle of incidence at the river equals the angle of reflection, which is option B.
  #figure(
    image(
      "River mirror.svg",
      width: 50%,
      alt: "Same as previous image with mirror image of Town 1. Option B corresponds to the a straight line from the mirror image to Town 2, and option C corresponds to a path consists of two segments joined at an angle at the river.",
    ),
    caption: [
      The yellow path shares the same length as the gray path (Option C), and the red path (Option B) corresponds to the straight line from the mirror image to Town 2.
    ],
  )

  I think this is a extremely clever solution!
  It is so clever that I don't think I could come up with it and I find the idea hard to extrapolate to other problems.
  Luckily, mathematicians have developed the so-called *Lagrange multipliers* to solve this kind of optimization problems under constraints, and the perk is that it reveals just as much geometric insight and can be applied to a much wider range of problems.

  I can give you a glimpse at the idea.
  Imagine that the river is actually a rail, and on the rail, there is a bead that can slide freely.
  We can thread a string through Town 1 (as an abstract fixed point), the bead, and Town 2.
  The shortest path will be revealed if we just pull the string tight.
  #figure(
    image(
      "River string.svg",
      width: 50%,
      alt: "A red dot on the blue line and a white path that coincides with the shortest path. Force vectors are drawn on the bead, two parallel to the white path and one perpendicular to the blue line.",
    ),
    caption: [
      The red dot on the blue line represents the bead and the white path represents the string.
    ],
  )
  At that equilibrium point, the tension forces, represented by the red vectors, must be perpendicular to the rail.
  Hence, we arrive at the same geometric insight that the shortest path must satisfy that the angle of incidence equals the angle of reflection.

  Lagrange multipliers method, in a nutshell, is this idea that something is optimized under constraint when the best direction of optimization is perpendicular to the constraint.
  To formulate this idea mathematically is why we begin by studying vectors.
]

= Vectors

In a 2-dimensional space, a vector is two numbers put in angle brackets such as $arrow(v) = chevron.l 8, 6 chevron.r$.
A vector represents only a direction and a magnitude.
When we draw a vector, we have to choose a base point, but different choices of base points represent the same vector.
For example, the red vectors in the figure below both represent the same vector $arrow(v) = chevron.l 8, 6 chevron.r$.
#figure(
  image(
    "Vector.svg",
    width: 40%,
    alt: "A grid with two red vectors with the same length and direction but different base."
  ),
  caption: [
    The two red vectors represent the same vector $arrow(v) = chevron.l 8, 6 chevron.r = 8 hat(i) + 6 hat(j)$.
  ]
)
We can also write a vector in terms of the standard unit vectors $hat(i)$ and $hat(j)$ which are vectors with length 1 pointing in the cardinal directions, so the vector $arrow(v) = chevron.l 8, 6 chevron.r$ can also be written as $8 hat(i) + 6 hat(j)$.

There are operations that we can do with vectors.
In this discussion, we will just talk about addition, subtraction, and scalar multiplication.
- To add vectors, we put them head to tail.
  Algebraically, we simply add the corresponding components, so for example, $chevron.l 1, 2 chevron.r + chevron.l 3, 4 chevron.r = chevron.l 4, 6 chevron.r$.
  #figure(
    image(
      "Vector addition.svg",
      width: 30%,
      alt: "White arrows with the same base point labeled a and b. A red arrow from the base point to the opposite corner of the parallelogram formed by the white arrows labeled a + b."
    ),
    caption: [
      Addition of vectors.
    ]
  )
- There are two ways to think about $arrow(a) - arrow(b)$.
  One way is to think about it as the vector that when we add it to $arrow(b)$, we get $arrow(a)$.
  Another way is to think of it as adding $- arrow(b)$ (the vector with the same length as $arrow(b)$ but in the opposite direction) to $arrow(a)$.
  The latter has the benefit of obtaining a vector at the same base point.

  Algebraically, we can calculate it by subtracting the corresponding components, so for example, $chevron.l 1, 3 chevron.r - chevron.l 3, 4 chevron.r = chevron.l - 2, - 1 chevron.r$.
  #figure(
    image(
      "Vector subtraction.svg",
      width: 30%,
      alt: "White arrows with the same base point labeled a and b. A red arrow from the tip of b to the tip of a labeled a - b."
    ),
    caption: [
      Two ways to subtract vectors.
    ]
  )
- To scale a vector by a number, we multiply the length of the vector by that number (direction will be flipped if negative).
  Algebraically, we can calculate it by multiplying each component by that number, so for example, $2 chevron.l 1, 3 chevron.r = chevron.l 2, 6 chevron.r$.
  #figure(
    image(
      "Vector scaling.svg",
      width: 50%,
      alt: "An arrow labeled a, an arrow half of the length labeled 1/2 a, and an arrow pointing in the opposite direction with the same length as a labeled -a."
    ),
    caption: [
      Scaling of vectors.
    ]
  )

#exercise(label: [Exercise])[
  #set list(spacing: 1em)
  If vectors $arrow(a)$ and $arrow(b)$ are drawn with the same base point, which of the following vectors correspond to the vector from the base point to the midpoint between the tips of $arrow(a)$ and $arrow(b)$?
  #columns(2)[
    #context {
      let image-width = if target() == "html" { 30% } else { auto }
      figure(
        image(
          "Parallelogram.svg",
          width: image-width,
          alt: "White arrows one labeled a pointing up and right and one labeled b pointing to the right. A red arrow labeled question mark."
        )
      )
    }

    #colbreak()

    + $1/2 (arrow(a) + arrow(b))$
    + $arrow(a) + 1/2 (arrow(a) - arrow(b))$
    + $arrow(b) + 1/2 (arrow(a) - arrow(b))$
    + $arrow(a) - 1/2 (arrow(a) - arrow(b))$
    + $arrow(b) + 1/2 (arrow(b) - arrow(a))$
  ]
]
#solution[
  #columns(2)[
    Expressions 1, 3, and 4 correspond to the vector from the base point to the midpoint of the segment between $arrow(a)$ and $arrow(b)$.
    The interpretation of $1/2 (arrow(a) + arrow(b))$ is the half of the diagonal of the parallelogram shown in the vector addition figure.
      It is exactly the vector we want.
    The interpretation of the other expressions are shown in the following figure.

    #colbreak()

    #context {
      let image-width = if target() == "html" { 30% } else { auto }
      figure(
        image(
          "Parallelogram solution.svg",
          width: image-width,
          alt: "The previous figure with blue arrows labeled 1/2 (a - b) pointing up and left, one starting from the tip of a and one starting from the tip of b, and red arrows labeled 1/2 (b - a) pointing down and right, one starting from the tip of a and one starting from the tip of b."
        )
      )
    }
  ]
]
