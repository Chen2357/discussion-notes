#import "../Discussion.typ": *
#import "@preview/itemize:0.2.0"
#import "@preview/mannot:0.2.2": markrect

#show: itemize.default-enum-list
#show: discussion.with(number: 7, date: datetime(year: 2026, month: 2, day: 19))

= Warm-up

#exercise[
  Let $bf(F)(x, y) = x bf(i)$ be a vector field and $C$ be the quarter unit circle from $(0, 0)$ to $(1, 1)$, so it is oriented anticlockwise.
  Discuss with your group what the expression
  $
    integral_C bf(F) dot bf(v) dd(s)
  $
  might mean.
  Is it even well-defined?
  Why or why not?
]
#solution[
  The expression is not well-defined because $bf(v)$ is not well-defined.
  The velocity vector is not intrinsic to the curve $C$ and depends on how we parameterize $C$.
  If a parametrization is given, we can debate whether the expression should be defined, and the discussion ultimately boils down how much information does "a curve" contain.

  Mathematicians usually would agree that a curve contain information about its shape and orientation, but there is no consensus on whether a curve should come with a parameterization or not.
  I am of the opinion that line integrals should always be independent of the parameterization.
]

= Fundamental theorem of calculus for line integrals

#exercise[
  Let $U(x, y) = x y$ and $C$ be the curve along $y = sqrt(x)$ starting from $(0, 0)$ and ending at $(1, 1)$.
  + Let's decide as a class on a parameterization $bf(r)(t)$ of $C$ such that $dv(bf(r), t)$ is nice.
  + Find the expression for $U(bf(r(t)))$, which are the values of $U$ at $bf(r)(t)$, and compute its derivative
    $
      dv(, t) (U(bf(r(t)))).
    $
  + Compute the gradient $nabla U (bf(r(t)))$ of $U$ at $bf(r)(t)$, and then compute the dot product
    $
      nabla U (bf(r(t))) dot dv(bf(r), t).
    $
    You should find that the result is the same as the previous part.
    Discuss with your group what this tells us about the line integral
    $
      integral_C nabla U dot dd(bf(r)).
    $
]
#solution[
  + We can parameterize $C$ by $bf(r)(t) = t^2 bf(i) + t bf(j)$ for $t in [0, 1]$.
    We would have
    $
      dv(bf(r), t) = 2t bf(i) + bf(j),
    $
    which is nice compare to the alternative parameterization $bf(r)(u) = u bf(i) + sqrt(u) bf(j)$ for $u in [0, 1]$ that gives
    $
      dv(bf(r), u) = bf(i) + (1/(2 sqrt(u))) bf(j).
    $
  + We have
    $
      U(bf(r(t))) = U(t^2, t) = t^3,
    $
    and
    $
      dv(, t) (U(bf(r(t)))) = 3 t^2.
    $
  + We have
    $
      nabla U (x, y) = y bf(i) + x bf(j) quad "and" quad nabla U (bf(r(t))) = t bf(i) + t^2 bf(j),
    $
    so
    $
      nabla U (bf(r(t))) dot dv(bf(r), t) = (t bf(i) + t^2 bf(j)) dot (2t bf(i) + bf(j)) = 3 t^2.
    $
    The discussion to be had here is that the line integral can be expressed as the integral of a derivative:
    $
      integral_C nabla U dot dd(bf(r)) = integral_0^1 nabla U (bf(r(t))) dot dv(bf(r), t) dd(t) = integral_0^1 dv(, t) (U(bf(r(t)))) dd(t),
    $
    and hence can be easily computed by the fundamental theorem of calculus as
    $
      integral_0^1 dv(, t) (U(bf(r(t)))) dd(t) = U(bf(r(1))) - U(bf(r(0))) = 1.
    $
]

The above argument is very general.
For any function $U$ (even those in higher dimensions like $U(x, y, z)$) and any curve $C$ parameterized by $bf(r)(t)$ (with $t in [t_0, t_1]$), we have by chain rule,
$
  dv(, t) (U(bf(r(t)))) = nabla U (bf(r(t))) dot dv(bf(r), t),
$
and by the fundamental theorem of calculus,
$
  integral_(t_0)^(t_1) nabla U (bf(r(t))) dot dv(bf(r), t) dd(t) = integral_(t_0)^(t_1) dv(, t) (U(bf(r(t)))) dd(t) = U(bf(r(t_1))) - U(bf(r(t_0))).
$
We know from the last discussion that
$
  integral_C nabla U dot dd(bf(r)) = integral_(t_0)^(t_1) nabla U (bf(r(t))) dot dv(bf(r), t) dd(t)
$
is actually independent of the choice of parameterization $bf(r)(t)$, so we can simply say
$
  markrect(padding: #0.5em, integral_C nabla U dot dd(bf(r)) = U(bf(B)) - U(bf(A)))
$
where $bf(A)$ and $bf(B)$ are the starting and ending points of $C$ respectively.
This is called the *fundamental theorem of calculus for line integrals*, and it is simply a statement about a curve and a function with no mention of parameterization at all!

In the previous exercise, we actually did not have to use the fact that curve $C$ is along $y = sqrt(x)$.
For any curve $C'$ starting from $(0, 0)$ and ending at $(1, 1)$, we would have the same result
$
  integral_C' nabla U dot dd(bf(r)) = U(1, 1) - U(0, 0) = 1.
$

= Finding a potential function

A vector field $bf(F)$ is called *conservative* if the line integral
$
  integral_C bf(F) dot dd(bf(r))
$
only depends on the starting and ending points of $C$ but not on the way we get from the starting point to the ending point.
By the fundamental theorem of calculus for line integrals, $bf(F)$ is conservative precisely when $bf(F) = nabla U$ for some function $U$.
We call such a function $U$ a *potential function* for $bf(F)$.

We will be thrilled if we know that a vector field $bf(F)$ is conservative because then we can easily compute line integrals of $bf(F)$ along any curve $C$ just by evaluating a potential function $U$ at the starting and ending points of $C$.

I will show you two methods to find a potential function if we know for sure that $bf(F)$ is conservative.
We will learn a method to check whether a vector field is conservative later.

#theorem[
  #text(dark-magenta)[(Method 1: line integral)]
  Leveraging the fundamental theorem of calculus for line integrals, we know
  $
    U(x, y, z) - U(0, 0, 0) = integral_(C(x, y, z)) bf(F) dot dd(bf(r))
  $
  where $C(x, y, z)$ is any curve starting from $(0, 0, 0)$ and ending at $(x, y, z)$.
  Now, since $U(0, 0, 0)$ is constant and adding a constant to a potential function does not change the gradient, the function
  $
    U(x, y, z) = integral_(C(x, y, z)) bf(F) dot dd(bf(r))
  $
  would be a fine potential function if one were to exist.

  One popular choice of $C(x, y, z)$ is $bf(r)(t) = (t x, t y, t z)$.
  Using this parameterization, the line integral becomes
  $
    U(x, y, z) &= integral_(0)^(1) bf(F)(bf(r)(t)) dot dv(bf(r), t) dd(t) \
    &= integral_0^1 bf(F)(t x, t y, t z) dot (x, y, z) dd(t).
  $
  We should verify that the resulting function $U$ satisfies $nabla U = bf(F)$ by computing the gradient of $U$.
  It is highly beneficial to do this check if we are doing this method because the computation still goes through and gives a false potential function when $bf(F)$ is not conservative.
]

The second method will only go through if $bf(F)$ is conservative.
If $bf(F)$ is not conservative, the calculation will alert us and fail at some point.

#theorem[
  #text(dark-magenta)[(Method 2: component by component)]
  Just like how we can solve $3 x = 432$ using long division by reducing the number of digits one by one:
  #figure(
    table(
      columns: 4,
      stroke: none,
      [], $100$, $+40$, $+4$,
      table.hline(start: 1),
      $3$, table.vline(start: 1, end: 2), $400$, $+30$, $+2$,
      [], $300$, [], [],
      table.hline(start: 1),
      [], $100$, $+30$, $+2$,
      [], $100$, $+20$, [],
      table.hline(start: 1),
      [], [], $10$, $+2$,
      [], [], $10$, $+2$,
      table.hline(start: 1),
      [], [], [], $0$
    ),
    caption: [Long division method to solve $3 x = 432$.]
  )
  We can solve $nabla U = bf(F)$ by reducing the problem one direction at a time.

  Let us say we are trying to find a potential function for the vector field $bf(F)(x, y) = y bf(i) + (x + 2 y) bf(j)$.
  First, we need to set up a table
  #figure(
    table(
      columns: 3,
      stroke: none,
      [], [], [],
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $y bf(i)$, $+(x + 2 y) bf(j)$
    )
  )
  Then, we need to find a function whose gradient has the correct $i$-component, in other words, a function whose $x$-derivative is $y$.
  We can use $x y$ (in general, we can use $x y$ plus any function of $y$), and we can compute its gradient $nabla (x y) = y bf(i) + x bf(j)$ and fill in the table
  #figure(
    table(
      columns: 3,
      stroke: none,
      [], $x y$, [],
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $y bf(i)$, $+(x + 2 y) bf(j)$,
      [], $y bf(i)$, $+ x bf(j)$
    )
  )
  We can perform the subtraction, and the crucial part is that *we expect the remainder to be independent of $x$*
  #figure(
    table(
      columns: 3,
      stroke: none,
      [], $x y$, [],
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $y bf(i)$, $+(x + 2 y) bf(j)$,
      [], $y bf(i)$, $+ x bf(j)$,
      table.hline(start: 1),
      [], [], $2 y bf(j)$
    )
  )
  We got $2 y bf(j)$ which is indeed independent of $x$, so we can proceed.
  If the remainder were to depend on $x$, then we should stop and apply the component test for conservative vector fields to see that the vector field is not conservative (and hence does not have a potential function).

  Now, we need to find a function independent of $x$ whose gradient is $2 y bf(j)$.
  We do not want one that depends on $x$ because that will undo our hard work to eliminate the $bf(i)$-component.
  We can use $y^2 + C$ for any constant $C$, and we can complete the table
  #figure(
    table(
      columns: 3,
      stroke: none,
      [], $x y$, $+ y^2 + C$,
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $y bf(i)$, $+(x + 2 y) bf(j)$,
      [], $y bf(i)$, $+ x bf(j)$,
      table.hline(start: 1),
      [], [], $2 y bf(j)$,
      [], [], $2 y bf(j)$,
      table.hline(start: 1),
      [], [], $0$
    )
  )
  The final reminder is $0$ and means that $nabla (x y + y^2 + C) = y bf(i) + (x + 2 y) bf(j)$.
  While this method never gives false results, we should still verify this by computing the gradient of $x y + y^2 + C$, mainly because I am the only one teaching you this.
]

#exercise[
  The vector field
  $
    bf(F)(x, y, z) = e^y bf(i) + (x e^y + z) bf(j) + y bf(k)
  $
  is conservative (I promise).
  Find its potential function $U(x, y, z)$ that satisfies $U(0, 0, 0) = 1$.
]
#solution[
  I will use method 2 to find a potential function for $bf(F)$.
  #figure(
    table(
      columns: 4,
      stroke: none,
      [], $x e^y$, $+ y z$, [],
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $e^y bf(i)$, $+(x e^y + z) bf(j)$, $+y bf(k)$,
      [], $e^y bf(i)$, $+ x e^y bf(j)$, [],
      table.hline(start: 1),
      [], [], $z bf(j)$, $+ y bf(k)$,
      [], [], $z bf(j)$, $+ y bf(k)$,
      table.hline(start: 1),
      [], [], [], $0$
    )
  )
  Thus, the general form of the potential function is $U(x, y, z) = x e^y + y z + C$ for any constant $C$.
  Using the condition $U(0, 0, 0) = 1$, we find that
  $
    U(0, 0, 0) = C = 1.
  $
  Thus, the potential function we are looking for is
  $
    U(x, y, z) = x e^y + y z + 1.
  $
]

= Component test for conservative vector fields

Notice that if $bf(F) = nabla U$, then the three components of $bf(F)$ are given by
$
  (F_x, F_y, F_z) = (pdv(U, x), pdv(U, y), pdv(U, z)).
$
Because partial derivatives commute, we can conclude that
$
  pdv(F_x, y) = pdv(U, y, x) = pdv(U, x, y) = pdv(F_y, x).
$
So if $bf(F)$ is conservative, then we must be able to exchange the subscript on $F$ with the variable of differentiation; and if we cannot, then $bf(F)$ cannot be conservative.
Similarly, we must have
$
  pdv(F_x, z) = pdv(F_z, x), quad pdv(F_y, z) = pdv(F_z, y).
$
If there is a pair of letters such that the corresponding equality does not hold, then $bf(F)$ cannot be conservative.
We can make this inference regardless whether the domain of $bf(F)$ is simply connected or not. _(Simply connected domains are those on which any two curves with the same starting and ending points can be deformed into each other fixing the endpoints.)_

#theorem[
  Suppose $bf(F) = (F_x, F_y)$.
  If
  $
    pdv(F_x, y) != pdv(F_y, x)
  $
  then $bf(F)$ is not conservative.
]

#theorem[
  Suppose $bf(F) = (F_x, F_y, F_z)$.
  If any of the following equalities does not hold
  $
    pdv(F_x, y) = pdv(F_y, x), quad pdv(F_x, z) = pdv(F_z, x), quad pdv(F_y, z) = pdv(F_z, y),
  $
  then $bf(F)$ is not conservative.
]

The component test says that more is true for simply connected domains, which is that if we can always exchange subscript and variable of differentiation, then $bf(F)$ must be conservative.
In three dimensions, we have a cute case that the curl
$
  nabla times bf(F) = (pdv(F_z, y) - pdv(F_y, z)) bf(i) + (pdv(F_x, z) - pdv(F_z, x)) bf(j) + (pdv(F_y, x) - pdv(F_x, y)) bf(k)
$
is zero if and only if all the equalities about exchanging subscript and variable of differentiation hold, so we can say that if the domain of $bf(F)$ is simply connected, then $bf(F)$ is conservative if and only if $nabla times bf(F) = 0$.

#exercise[
  // + Determine whether $bf(F) = y z bf(i) + x z bf(j) + x y bf(k)$ is conservative.
  #set enum(spacing: 1.5em)
  + Determine whether $bf(F)(x, y, z) = sin(x^2) bf(i) + z bf(j) + y bf(k)$ is conservative.
  + Determine whether $display(bf(F)(x, y, z) = e^x sin(y) bf(i) + e^x cos(y) bf(j) + e^x bf(k))$ is conservative.
  + The vector field $display(bf(F)(x, y) = (-y bf(i) + x bf(j))/(x^2 + y^2))$ satisfies
    $
      pdv(F_x, y) = (y^2 - x^2)/(x^2 + y^2)^2 = pdv(F_y, x),
    $
    discuss why we cannot conclude that $bf(F)$ is conservative.
    The vector field is indeed not conservative, discuss with your group about a way to show that.
    #figure(
      canvas(length: 0.8cm, {
        import cetz.draw: *
        let xn = 8
        let xmin = -4
        let xmax = 4

        let yn = 8
        let ymin = -4
        let ymax = 4

        let scale = 2
        let f(x, y) = (-y/(calc.pow(x, 2) + calc.pow(y, 2)), x/(calc.pow(x, 2) + calc.pow(y, 2)))
        let axis-padding = 0.5

        line((xmin - axis-padding, 0), (xmax + axis-padding, 0), stroke: gray, mark: (end: "straight"))
        line((0, ymin - axis-padding), (0, ymax + axis-padding), stroke: gray, mark: (end: "straight"))

        for x in nt.linspace(xmin, xmax, xn) {
          for y in nt.linspace(ymin, ymax, yn) {
            if calc.pow(x, 2) + calc.pow(y, 2) < 1 {
              continue
            }
            let p = (x, y)
            let v = f(x, y)
            line(p, nt.add(p, nt.mult(v, scale)), mark: (end: "stealth"), stroke: red, fill: red)
          }
        }
      }),
      caption: [Samples of the vector field $display(bf(F)(x, y) = (-y bf(i) + x bf(j))/(x^2 + y^2))$.
      The vector field is too large near the origin, so we excluded a small disk around the origin from the plot.
      ]
    )
]
#solution[
  + Note that the domain of $bf(F)$ is the whole 3-dimensional space, which is simply connected, so we can apply the component test for conservative vector fields.
    We have
    $
      pdv(F_x, y) = 0 = pdv(F_y, x), quad pdv(F_x, z) = 0 = pdv(F_z, x), quad pdv(F_y, z) = 1 = pdv(F_z, y),
    $
    so $bf(F)$ is conservative.
  + We have
    $
      pdv(F_x, z) = 0 != pdv(F_z, x) = e^x,
    $
    so $bf(F)$ is not conservative.
    We do not even need to check the other equalities.
    For the record, we have
    $
      pdv(F_x, y) = e^x cos(y) = pdv(F_y, x), quad pdv(F_y, z) = 0 = pdv(F_z, y).
    $
    If we were to calculate the curl of $bf(F)$, we would find that
    $
      nabla times bf(F) = e^x bf(j),
    $
    then again, the moment we find a nonzero component of the curl, we can conclude that $bf(F)$ is not conservative without checking the rest of the components.

    Just for fun, let us see what happens if we try to find a potential function for $bf(F)$ using method 2.
    #figure(
      table(
        columns: 4,
        stroke: none,
        [], $e^x sin(y)$, [], [],
        table.hline(start: 1),
        $nabla$, table.vline(start: 1, end: 2), $e^x sin(y) bf(i)$, $+ e^x cos(y) bf(j)$, $+ e^x bf(k)$,
        [], $e^x sin(y) bf(i)$, $+ e^x cos(y) bf(j)$, [],
        table.hline(start: 1),
        [], [], [], $e^x bf(k)$,
      )
    )
    As you can see from the table, we would get a remainder of $e^x bf(k)$ which depends on $x$, and this should not happen after we eliminate the $bf(i)$-component.
    The table suggests that something is incompatible about the $x$- and $z$-components of $bf(F)$, which is exactly what we found.

  + The domain of $bf(F)$ is the 2-dimensional plane with the origin removed, which is not simply connected, so we cannot apply the component test for conservative vector fields.

    Looking at the plot of $bf(F)$, we can see that if we do a line integral along say the unit circle anticlockwise, $bf(F) dot dv(bf(r), t)$ would be positive, and the line integral would be positive.
    This cannot happen if $bf(F)$ were conservative because the line integral along a closed curve must be zero for conservative vector fields (if the endpoints are the same, the difference between the values of the potential function at the endpoints would be zero).

    Concretely, we can parameterize the unit circle by $bf(r)(t) = cos(t) bf(i) + sin(t) bf(j)$ for $t in [0, 2 pi]$, and we can compute
    $
      integral_C bf(F) dot dd(bf(r)) &= integral_0^(2 pi) bf(F)(bf(r)(t)) dot dv(bf(r), t) dd(t) \
      &= integral_0^(2 pi) (-sin(t) bf(i) + cos(t) bf(j)) dot (-sin(t) bf(i) + cos(t) bf(j)) dd(t) \
      &= integral_0^(2 pi) 1 dd(t) = 2 pi != 0.
    $
]

