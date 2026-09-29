#import "../Discussion.typ": *

#show: discussion.with(number: 6, date: datetime(year: 2026, month: 2, day: 12))

#set math.equation(numbering: "(1)", supplement: "Eq.")
#show math.equation: it => {
  if it.block and not it.has("label") and it.numbering != none {
    counter(math.equation).update(v => v - 1)
    math.equation(it.body, block: true, numbering: none)
  } else {
    it
  }
}

= Warm-up

#exercise[
  Suppose that we have some one-to-one correspondence between $(x, y)$ and $(u, v)$ (perhaps $x = g(u, v)$, $y = h(u, v)$, $u = U(x, y)$ and $v = V(x, y)$).
  Consider the assertions
  $
    dd(x, y) = abs(pdv((x, y), (u, v))) dd(u, v) quad "and" quad
    dd(u, v) = abs(pdv((u, v), (x, y))) dd(x, y).
  $
  Discuss in your group, what can you say about the relationship between $abs(pdv((x, y), (u, v)))$ and $abs(pdv((u, v), (x, y)))$?

  Additionally, think about what $abs(pdv((x, y), (u, v)))$ and $abs(pdv((u, v), (x, y)))$ are functions of.
  How can two functions of different variables have a relationship with each other?
]
#solution[
  If we substitute $dd(x, y)$ in the first equation into the second equation, we would get
  $
    dd(u, v) = abs(pdv((u, v), (x, y))) abs(pdv((x, y), (u, v))) dd(u, v).
  $
  This tells us that
  $
    abs(pdv((u, v), (x, y))) abs(pdv((x, y), (u, v))) = 1.
  $ <eq_1>
  In other words, $abs(pdv((u, v), (x, y)))$ and $abs(pdv((x, y), (u, v)))$ are reciprocals of each other.

  There is a subtle issue that $abs(pdv((u, v), (x, y)))$ is a function of $x$ and $y$, while $abs(pdv((x, y), (u, v)))$ is a function of $u$ and $v$.
  What @eq_1 is really saying is that if we substitute $x = g(u, v)$ and $y = h(u, v)$ into $abs(pdv((u, v), (x, y)))$ and then multiply it with $abs(pdv((x, y), (u, v)))$, we would get $1$.
]

= Tangent vector, normal vector, and curvature

Recall that given a curve $bf(r)(t)$, we have various quantities associated with it.
Here are some formulas for them if the curve $bf(r)(t)$ is sufficiently regular.
$
  "velocity vector" &: quad bf(v) = dv(bf(r), t) \
  "(unit) tangent vector" &: quad bf(T) = bf(v)/abs(bf(v)) \
  "curvature" &: quad kappa = 1/abs(dv(bf(r), t, style: "horizontal")) abs(dv(bf(T), t)) \
  "(principal) normal vector" &: quad bf(N) = dv(bf(T), t, style: "horizontal")/abs(dv(bf(T), t, style: "horizontal"))
$
The normal vector is called a normal vector because it is perpendicular to the tangent vector.
It can be thought of as the acceleration if the tangent vector coincides with the velocity vector (i.e. we are moving at unit speed).
The acceleration will be always perpendicular to the velocity vector if our speed is constant.

The formulas for the tangent vector, curvature, and normal vector are not completely general because for the formula for $bf(T)$ to make sense, we need $bf(v)$ to be nonzero.
However, tangent vector, curvature, and normal vector can sometimes still be defined because they are intrinsic properties of the shape of the curve and independent of the parameterization.
We can freely reparameterize the curve to calculate the tangent vector, curvature, and normal vector.
If $u = U(t)$ is a strictly increasing function of $t$, then we would still have
$
  bf(T) &= dv(bf(r), u, style: "horizontal")/abs(dv(bf(r), u, style: "horizontal")), quad
  kappa &= 1/abs(dv(bf(r), u, style: "horizontal")) abs(dv(bf(T), u)), quad
  bf(N) &= dv(bf(T), u, style: "horizontal")/abs(dv(bf(T), u, style: "horizontal"))
$
given that $bf(r)(u) = bf(r)(t)$ when we substitute $u = U(t)$.
A choice of reparameterization that will always work (if you can evaluate the arc length integral) is the arc length parameterization, which is given by
$
  s(t) = integral_0^t abs(bf(v)(tau)) dd(tau).
$
In which case, $abs(dv(bf(r), s, style: "horizontal")) = 1$ (verify this!), and the formulas become
$
  bf(T) &= dv(bf(r), s), quad
  kappa &= abs(dv(bf(T), s)), quad
  bf(N) &= dv(bf(T), s, style: "horizontal")/abs(dv(bf(T), s, style: "horizontal")).
$
Because arc length parameterization always works, we often define these quantities by the above formulas.

#exercise[
  Consider the circle $bf(r)(t) = 3 cos(t) bf(i) + 3 sin(t) bf(j)$ of radius $3$.
  Also consider the same circle with another parameterization $bf(r)(u) = 3 cos(u^3) bf(i) + 3 sin(u^3) bf(j)$.
  + Calculate the velocity vector, tangent vector, curvature, and normal vector of $bf(r)(t)$.
  + Find the arc length parameterization $bf(r)(s)$.
  + Discuss what happens if we try to calculate velocity vector, tangent vector, curvature, and normal vector of $bf(r)(u)$ at $u = 0$.
    Are these quantities still meaningful at $u = 0$?
]
#solution[
  + We have
    $
      bf(v) &= dv(bf(r), t) = -3 sin(t) bf(i) + 3 cos(t) bf(j), \
      abs(bf(v)) &= 3, \
      bf(T) &= bf(v)/abs(bf(v)) =  -sin(t) bf(i) + cos(t) bf(j), \
      dv(bf(T), t) &= -cos(t) bf(i) - sin(t) bf(j), \
      kappa &= 1/abs(dv(bf(r), t, style: "horizontal")) abs(dv(bf(T), t)) = 1/3, \
      bf(N) &= dv(bf(T), t, style: "horizontal")/abs(dv(bf(T), t, style: "horizontal")) = -cos(t) bf(i) - sin(t) bf(j).
    $
    #h(100%)
  + Note that
    $
      s = integral_0^t abs(bf(v)(tau)) dd(tau) = integral_0^t 3 dd(tau) = 3t.
    $
    Therefore, we have $t = s/3$, and $bf(r)(s) = 3 cos(s/3) bf(i) + 3 sin(s/3) bf(j)$ is the arc length parameterization.
  + The velocity vector of $bf(r)(u)$ at $u = 0$ is
    $
      dv(bf(r), u) = -9 u^2 sin(u^3) bf(i) + 9 u^2 cos(u^3) bf(j),
    $
    which is the zero vector at $u = 0$.
    Using the naive formulas for the tangent vector, curvature, and normal vector, we would encounter division by zero.
    Nevertheless, these quantities are still meaningful at $u = 0$ because we can reparameterize the curve using $bf(r)(t)$ or $bf(r)(s)$, and we will get the same results.
]

= Line integrals of scalar and vector functions

#theorem[
  If $f$ is defined on a curve $C$ given by $bf(r)(t) = g(t) bf(i) + h(t) bf(j) + k(t) bf(k)$ for $a <= t <= b$, then the line integral of $f$ along $C$ is given by
  $
    integral_C f(x, y, z) dd(s) = integral_a^b f(g(t), h(t), k(t)) abs(dv(bf(r), t)) dd(t).
  $
]
This is really analogous to other theorems like Fubini's theorem or multivariable substitutions in the sense that this is not the definition of the line integral (the definition is using limit, see textbook page 966), but it is a theorem that allows us to compute line integrals using a single-variable integral.
Note that the differential $dd(s)$ is similar to $dd(A)$ or $dd(V)$, it is not saying that you must use arc length reparameterization.

In fact, the theorem has so much more freedom than Fubini's theorem because Fubini's theorem only gives us $2$ choices to evaluate a double integral (casting it to an iterated integral with $dd(x, y)$ or $dd(y, x)$) or $6$ choices in $3$ dimensions.
However, the above theorem allows us to use any parameterization of the curve and there are infinitely many parameterizations that we can choose from.
$
  "Fubini (2 choices):" quad
  & integral_R f(x, y) dd(A) &&= integral_a^b integral_(g_1(y))^(g_2(y)) f(x, y) dd(x, y) \
  & &&= integral_c^d integral_(h_1(x))^(h_2(x)) f(x, y) dd(y, x) \
  "Substitutions (infinite choices):" quad
  & integral_R f(x, y) dd(A) &&= integral_G F(u, v) abs(pdv((x, y), (u, v))) dd(u, v) \
  & &&= integral_G F(r, theta) r dd(r, theta) = dots.c \
  "Line integrals (infinite choices):" quad
  & integral_C f(x, y, z) dd(s) &&= integral_a^b f(g(t), h(t), k(t)) abs(dv(bf(r), t)) dd(t) \
  & &&= integral_0^L f(g(s), h(s), k(s)) underbrace(abs(dv(bf(r), s)), 1) (s) = dots.c
$

#pagebreak()
#exercise[
  Consider the curve $C$ given by $bf(r)(t) = cos(e^t) bf(i) + e^t bf(j) + sin(e^t) bf(k)$ for $0 <= t <= 1$.
  + Evaluate $abs(dv(bf(r), t))$ as a function of $t$.
  + The arc length of $C$ is defined as
    $
      integral_C 1 dd(s).
    $
    Evaluate the arc length of $C$.
    #h(100%)
  + Discuss what happens if we change the curve $C$ to be given by $bf(r)(t) = cos(e^((t^2))) bf(i) + e^((t^2)) bf(j) + sin(e^((t^2))) bf(k)$ for $0 <= t <= 1$.
    How can we still calculate the arc length with ease?
]
#solution[
  + We have
    $
      dv(bf(r), t) &= -e^t sin(e^t) bf(i) + e^t bf(j) + e^t cos(e^t) bf(k), \
      abs(dv(bf(r), t)) &= sqrt(e^(2t) sin^2(e^t) + e^(2t) + e^(2t) cos^2(e^t)) = sqrt(2 e^(2t)) = sqrt(2) e^t.
    $
    #h(100%)
  + By the line integral to single-variable integral formula, we have
    $
      integral_C 1 dd(s) = integral_0^1 abs(dv(bf(r), t)) dd(t) = integral_0^1 sqrt(2) e^t dd(t) = sqrt(2) (e - 1).
    $
  + The line integral
    $
      integral_C 1 dd(s)
    $
    is independent of the parameterization of $C$, so we will for sure get the same answer $sqrt(2) (e - 1)$.
    In fact instead of doing what we did, we can go even further and use the parameterization
    $
      bf(r)(u) = cos(u) bf(i) + u bf(j) + sin(u) bf(k) quad "for" quad 1 <= u <= e.
    $
    This still parametrizes the same curve $C$, and we can evaluate the line integral by
    $
      integral_C 1 dd(s) &= integral_1^e abs(dv(bf(r), u)) dd(u) \
      &= integral_1^e sqrt(sin^2(u) + 1 + cos^2(u)) dd(u) \
      &= integral_1^e sqrt(2) dd(u) = sqrt(2) (e - 1).
    $
]

#theorem[
  If $bf(F)$ is a vector field along a curve $C$ given by $bf(r)(t) = g(t) bf(i) + h(t) bf(j) + k(t) bf(k)$ for $a <= t <= b$, then the line integral of $bf(F)$ along $C$ is given by
  $
    integral_C bf(F) dot dd(bf(r)) = integral_a^b bf(F)(t) dot dv(bf(r), t) dd(t)
  $
  where $bf(F)(t)$ should equal $bf(F)$ evaluated at the point $bf(r)(t)$ (if $bf(F)$ is defined in terms of $x$, $y$, and $z$, then we should substitute $x = g(t)$, $y = h(t)$, and $z = k(t)$ into $bf(F)$ to get $bf(F)(t)$).
]

#exercise[
  Let $bf(F) = y bf(i) + bf(j)$ and the curve $C$ be given by $bf(r)(t) = t bf(i) + 2 t bf(j)$ for $0 <= t <= 1$.
  + Evaluate
    $
      integral_C bf(F) dot dd(bf(r)).
    $
    #h(100%)
  + Consider the following incorrect solution:
    #align(
      center,
      box(stroke: red + 1pt, width: 100%)[
        #place(
          top + right,
        )[
          #show: box.with(inset: 6pt)
          #show: box.with(fill: red.lighten(50%), inset: 4pt, radius: 7pt)
          Incorrect solution
        ]
        #show: box.with(inset: (top: 1em, bottom: 1em))
        $
          integral_C bf(F) dot dd(bf(r)) &= integral_C y dd(x) + integral_C 1 dd(y) \
          &= integral_0^1 y dd(x) + integral_0^2 1 dd(y) \
          &= y + 2.
        $
      ]
    )
    Discuss what are the mistakes in the above solution and how to fix them if one insists on this method.
]
#solution[
  + We have
    $
      integral_C bf(F) dot dd(bf(r)) &= integral_0^1 bf(F)(t) dot dv(bf(r), t) dd(t) \
      &= integral_0^1 (2 t bf(i) + bf(j)) dot (bf(i) + 2 bf(j)) dd(t) \
      &= integral_0^1 (2 t + 2) dd(t) \
      &= [t^2 + 2t]_0^1 = 3.
    $
    #h(100%)
  + The most alarming tell in the correct solution is that the line integral of a vector field should be a single number, but the incorrect solution gives a function in $y$.
    This suggests that there must be some mistake in the incorrect solution.
    Doing "type checking" like this is a very important skill to have when doing calculations.

    The mistake is the misinterpretation of the line integrals
    $
      integral_C y dd(x) quad "and" quad integral_C 1 dd(y).
    $
    In the line integral, $x$ and $y$ are functions of the parameter $t$.
    For our parameterization, we have
    $
      x(t) = t, quad y(t) = 2 t.
    $
    If we insist, the correct way to interpret the line integral is
    $
      integral_C y dd(x) = integral_0^1 y(t) dv(x, t) dd(t) = integral_0^1 2 t dd(t) = 1, \
    $
    and similarly,
    $
      integral_C 1 dd(y) = integral_0^1 1 dv(y, t) dd(t) = integral_0^1 2 dd(t) = 2.
    $
    Adding them up, we would get the correct answer $3$.
]