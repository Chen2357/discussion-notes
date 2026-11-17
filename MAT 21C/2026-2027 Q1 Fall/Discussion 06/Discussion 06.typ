#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#set math.accent(dotless: false)
#let dd = physica.dd.with(d: $d$)

#set document(
  title: "Discussion 6 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 11, day: 3),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Contours.svg" : "32489076",
    "Function contour plot.svg" : "32489078",
    "Point and plane.svg" : "32489081",
    "Function graph.png" : "32489080",
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

= Warm-Up

#exercise(label: [Warm-up])[
  Given some random planes and lines in three dimensions, categorize the following scenarios as either "almost never occur" or "almost always occur":
  + A plane and a line intersect.
  + Two planes intersect.
  + Two lines intersect.
]
#solution[
  + A plane and a line intersect: almost always occur.
    This is related to the fact that a plane is described by one equation
    $
      a x + b y + c z = d
    $
    with variables $x, y, z$ and a line is described by three equations
    $
      x = x_0 + t v_1, quad
      y = y_0 + t v_2, quad
      z = z_0 + t v_3
    $
    with variables $x, y, z, t$.
    We have four variables and four equations in total, and hence we expect a solution to exist.
    That single solution would be the intersection point of the plane and the line.
  + Two planes intersect: almost always occur.
    Two planes are described by two equations
    $
      a_1 x + b_1 y + c_1 z = d_1, quad
      a_2 x + b_2 y + c_2 z = d_2.
    $
    Because we have three variables $x$, $y$, and $z$ and two equations, we expect that we have a solution and some leeway to vary one of the variables.
    For example, we can fix $z$ to be $3$ or any other number, and then we can solve for $x$ and $y$ (two equations, two unknowns after setting $z$, we should expect a solution).
    The leeway to vary a variable means that the intersection of two planes is a line instead of a single point.
  + Two lines intersect: almost never occur.
    Two lines are described by six equations
    $
      cases(
        x = x_1 + t v_1\,,
        y = y_1 + t v_2\,,
        z = z_1 + t v_3\,,
      )
      quad "and" quad
      cases(
        x = x_2 + s w_1\,,
        y = y_2 + s w_2\,,
        z = z_2 + s w_3\.,
      )
    $
    We have five variables $x$, $y$, $z$, $t$, and $s$ and six equations.
    Because we have more equations than variables, we expect that there is no solution in general.
    This corresponds to the fact that two lines in three dimensions are almost never intersecting.
]

= Lines and Planes

Expanding on the previous discussion notes on shapes (which we did not have time to cover), let us discuss lines and planes in three dimensions.

In math, equations describe shapes.
More precisely, a shape is just a collection of points, and the solutions to an equation also form a collection of points.
We say that the shape is described by the equation if these two collections of points are the same.

Consider the unit circle in the $x y$-plane and the equation $x^2 + y^2 = 1$ and two questions:
- Is the point $(1, 2)$ on the unit circle?
- Does the point $(1, 2)$ solve the equation $x^2 + y^2 = 1$?
The answer to both questions is no, but this is not a coincidence---we have to realize that these two questions are fundamentally the same question.
For any fixed numbers $a$ and $b$, the questions
- Is the point $(a, b)$ on the the unit circle?
- Does the point $(a, b)$ solve the equation $x^2 + y^2 = 1$?
are equivalent questions.
This is the reason why we say that the unit circle is described by the equation $x^2 + y^2 = 1$.

Let us figure out what equation describes a plane that passes through $(-3, 0, 7)$ perpendicular to $arrow(n) = 5 hat(i) + 2 hat(j) - hat(k)$.
Consider a random point $(10, 10, 10)$, how do we know whether this point is on the plane?
Looking at the figure below, we see that we can draw a vector from $(-3, 0, 7)$ to $(20, 10, 10)$, and if this vector is perpendicular to $arrow(n)$, then the point is on the plane.
#figure(
  image(
    "Point and plane.svg",
    width: 70%,
    alt: "A plane with a base point and a red normal vector at the point. Two vectors from the base point to two points in the distance. One vector is perpendicular to the red vector and one is not.",
  ),
  caption: [
    To check whether a test point way out in space is on a plane, we can draw a vector from a known point on the plane to the test point.
    If the vector is perpendicular to the normal vector of the plane, then the test point is on the plane; otherwise, it is not.
  ]
)
The vector from $(-3, 0, 7)$ to $(10, 10, 10)$ is
$
  chevron(10 - (-3)\, 10 - 0\, 10 - 7) = chevron(13\, 10\, 3).
$
Checking whether this vector is perpendicular to $arrow(n)$, we compute the dot product:
$
  chevron(13\, 10\, 3) dot chevron(5\, 2\, -1) = 13 dot.c 5 + 10 dot.c 2 + 3 dot.c (-1) = 65 + 20 - 3 = 82 != 0.
$
Because the dot product is not zero, we conclude that the point $(10, 10, 10)$ is not on the plane.
This process works for any point in space, to check whether a point $(x, y, z)$ is on the plane, we just check whether
$
  chevron(x - (-3)\, y - 0\, z - 7) dot chevron(5\, 2\, -1) = 0
$
is true.
The equation simplifies to
$
  chevron(x + 3\, y\, z - 7) dot chevron(5\, 2\, -1) = 0
  quad "or equivalently" quad
  5 (x + 3) + 2 y - (z - 7) = 0.
$
This is the equation that describes the plane because a point $(x, y, z)$ is on the plane if and only if it satisfies this equation.

In general, if a plane passes through a point $(x_0, y_0, z_0)$ and is perpendicular to a vector $arrow(v) = a hat(i) + b hat(j) + c hat(k)$, then the equation of the plane is
$
  chevron(x - x_0\, y - y_0\, z - z_0) dot chevron(a\, b\, c) = 0
  quad "or equivalently" quad
  a (x - x_0) + b (y - y_0) + c (z - z_0) = 0.
$

I will just briefly cover the parametric equations of lines in three dimensions.
A line that passes through a point $(x_0, y_0, z_0)$ and is parallel to a vector $arrow(v) = chevron(v_1\, v_2\, v_3)$ is given by the parametric equation ("parametric" because there is a parameter $t$ that is allowed to vary)
$
  chevron(x\, y\, z) = chevron(x_0\, y_0\, z_0) + t chevron(v_1\, v_2\, v_3).
$
We check whether a point, say $(1, 3, 5)$ is on the line by checking whether there is a $t$ that solves
$
  chevron(1\, 3\, 5) = chevron(x_0\, y_0\, z_0) + t chevron(v_1\, v_2\, v_3).
$

#exercise[
  + Two of the following points are in the the intersection of the planes described by $x - 2 y + z = 0$ and $2 x + y - z = 5$.
    Find them.
    #let options = (
      $(1, 3, 5)$,
      $(1, -2, -5)$,
      $(2, 1, 0)$,
      $(0, 5, 10)$,
    )
    #context if target() == "html" {
      list(..options)
    } else {
      columns(4, {
        options.map(it => [- #it]).join(colbreak())
      })
    }
    The intersection of the two planes is a line.
    Find a nonzero vector parallel to the line by taking the difference of the two points you found.
  + Find a nonzero vector orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$.
    Is this vector related to your answer to part 1?
  + Do these two equations describe the same plane?
    $
      2 x + y - z = 3 quad "and" quad 4 x + 2 y - 2 z = 6.
    $
    If not, find a point that is on one of the planes but not the other.
  + Do these two parametric equations describe the same line?
    $
      chevron.l x, y, z chevron.r = chevron.l 1, 0, 0 chevron.r + t chevron.l 1, 0, 2 chevron.r quad "and" quad
      chevron.l x, y, z chevron.r = chevron.l 2, 0, 0 chevron.r + s chevron.l 2, 0, 4 chevron.r.
    $
    If not, find a point that is on one of the lines but not the other.
]
#solution[
  + We can check if a point is in the intersection of the two planes by substituting the coordinates of the point into the equations of the planes and checking if both equations hold.
    - For $(1, 3, 5)$, we have $1 - 2 (3) + 5 = 0$ and $2 (1) + 3 - 5 = 0 != 5$, so it is not in the intersection.
    - For $(1, - 2, - 5)$, we have $1 - 2 (- 2) + (- 5) = 0$ and $2 (1) + (- 2) - (- 5) = 5$, so it is in the intersection.
    - For $(2, 1, 0)$, we have $2 - 2 (1) + 0 = 0$ and $2 (2) + 1 - 0 = 5$, so it is in the intersection.
    - For $(0, 5, 10)$, we have $0 - 2 (5) + 10 = 0$ and $2 (0) + 5 - 10 = - 5 != 5$, so it is not in the intersection.
    Therefore, the two points in the intersection are $(1, -2, -5)$ and $(2, 1, 0)$.

    A nonzero vector parallel to the line of intersection can be found by taking the difference of the two points:
    $
      chevron.l 2, 1, 0 chevron.r - chevron.l 1, - 2, - 5 chevron.r = chevron.l 1, 3, 5 chevron.r .
    $
  + We can find a nonzero vector orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$ by taking the cross product of the two vectors:
    $
      chevron.l 1, - 2, 1 chevron.r times chevron.l 2, 1, - 1 chevron.r = mat(delim: "|", hat(i), hat(j), hat(k); 1, - 2, 1 ; 2, 1, - 1) = hat(i) mat(delim: "|", - 2, 1 ; 1, - 1) - hat(j) mat(delim: "|", 1, 1 ; 2, - 1) + hat(k) mat(delim: "|", 1, - 2; 2, 1) = 1 hat(i) + 3 hat(j) + 5 hat(k) .
    $
    This is exactly the same vector we found in part 1!
    This is no coincidence because vectors parallel to the planes $x - 2 y + z = 0$ and $2 x + y - z = 5$ are orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$ respectively, so a vector parallel to the line of intersection should be orthogonal to both $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$.
    Therefore, part 1 and part 2 are secretly the same question.
  + The two equations describe the same plane because they describe the same collection of points.
    If a point $(x, y, z)$ satisfies $2 x + y - z = 3$, then it must also satisfy $4 x + 2 y - 2 z = 6$ and vice versa.
  + The two parametric equations describe different lines.
    For example, the point $(2, 0, 0)$ is on the second line because we can solve
    $
      chevron.l 2, 0, 0 chevron.r = chevron.l 2, 0, 0 chevron.r + s chevron.l 2, 0, 4 chevron.r <== s = 0.
    $
    However, the point $(2, 0, 0)$ is not on the first line because we cannot solve
    $
      chevron.l 2, 0, 0 chevron.r = chevron.l 1, 0, 0 chevron.r + t chevron.l 1, 0, 2 chevron.r
    $
    because it is the system of equations
    $
      cases(
        2 = 1 + t\,,
        0 = 0 + 0 t\,,
        0 = 0 + 2 t\,,
      )
    $
    and while the first equation wants $t = 1$, the third equation wants $t = 0$, so there is no solution.

    Another way to look at this is to recognize that the two lines are parallel because the vectors that indicate the direction of the lines, $chevron.l 1, 0, 2 chevron.r$ and $chevron.l 2, 0, 4 chevron.r$, are parallel.
    However, one passes through the point $(1, 0, 0)$ and the other passes through the point $(2, 0, 0)$ whose difference is $chevron.l 1, 0, 0 chevron.r$ which is not parallel to the direction vector of the lines, so the two lines are parallel but not the same line.
]

= Functions of Several Variables

A function $f(x, y)$ of two variables is an assignment of a number to each point $(x, y)$ in its domain.
We can graph the function as a surface in three dimensions, described by the equation $z = f(x, y)$.
Again, the idea is that a point $(x, y, z)$ is on the surface if and only if it satisfies the equation $z = f(x, y)$.

The function $f(x, y) = 100 - x^2 - y^2$ looks like the following figure.
#figure(
  image(
    "Function graph.png",
    width: 40%,
    alt: "A paraboloid, labeled the graph of f, centered at the origin and has a peak above the origin at height 100.",
  ),
  caption: [
    The graph of the function $f(x, y) = 100 - x^2 - y^2$.
    Image from Figure 14.5 in the textbook.
  ]
)
The peak of the surface is at $(0, 0, 100)$ and is where the $z$-axis pierces the surface.

Another way to visualize the function is to look at the level curves, which are the red circles in the figure above.
A level curve is again a shape, and hence described by an equation, and in particular, the level curves are the equations $f(x, y) = "constant"$.
For example, $100 - x^2 - y^2 = 75$ is a level curve of the function $f(x, y) = 100 - x^2 - y^2$ for value $75$.
The equation is equivalent to
$
  x^2 + y^2 = 25
$
which we can easily see that it is the circle of radius $5$.

If we draw many level curves of the function, we obtain a contour plot of the function which reveals many geometric features without the need to visualize the surface in three dimensions.
#figure(
  image(
    "Function contour plot.svg",
    width: 40%,
    alt: "5 concentric circles centered at the origin labeled with numbers representing function values. The outermost circle has radius 10 and is labeled 0, and the innermost circle is labeled 90.",
  ),
  caption: [
    A contour plot of the function $f(x, y) = 100 - x^2 - y^2$.
  ]
)
For example, if we were to look at the point $A$, we can tell that the function value is somewhere between $50$ and $75$ and probably closer ot $75$.
We can also tell that as we move in the positive $x$-direction, following the red vector in the plot, the function value will increase and be higher than $75$.
The peak of the function is at $(0, 0)$ and we can tell because the level curves are circling around this point and the function values are increasing as we move towards this point.

#exercise[
  Consider the following contour plot of a function $f(x, y)$.
  #figure(
    image(
      "Contours.svg",
      width: 40%,
      alt: "Contour plot of a hill. Point A is at the bottom left, point B is at the bottom right, point C at the peak of the hill, and point D is at the top left.",
    ),
    caption: [
      A contour plot of a function $f(x, y)$.
    ]
  )
  + Order the function values at the points $A(a_1, a_2)$, $B(b_1, b_2)$, $C(c_1, c_2)$, and $D(d_1, d_2)$ from least to greatest.
  + For each point, determine whether the function value increases or decrease as we move in the positive $x$-direction and in the positive $y$-direction.
]
#solution[
  + The function values at the points from least to greatest are
    $
      f(a_1, a_2) < f(b_1, b_2) < f(d_1, d_2) < f(c_1, c_2).
    $
    To elaborate, $f(a_1, a_2)$ is between $60$ and $80$, $f(b_1, b_2)$ is between $140$ and $160$, $f(d_1, d_2)$ is between $160$ and $180$, and $f(c_1, c_2)$ is around the peak of the function at above $240$.
  + Here is the conclusion.
    - At point $A$, the function value _increases_ as we move in both the positive $x$-direction and the positive $y$-direction.
    - At point $B$, the function value _decreases_ as we move in the positive $x$-direction and _increases_ as we move in the positive $y$-direction.
    - At point $C$, the function value _decreases_ as we move in both the positive $x$-direction and the positive $y$-direction.
      In fact, it is at the peak of the function, so the function value decreases in all directions.
    - At point $D$, the function value _increases_ as we move in the positive $x$-direction and _decreases_ as we move in the positive $y$-direction.
]
