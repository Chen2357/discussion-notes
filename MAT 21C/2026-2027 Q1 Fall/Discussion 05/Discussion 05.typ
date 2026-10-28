#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#set math.accent(dotless: false)
#let dd = physica.dd.with(d: $d$)

#set document(
  title: "Discussion 5 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 10, day: 27),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Cross product.svg": "32344781",
    "Parallelepiped.svg": "32344782",
    "Projection onto plane.svg": "32344783",
    "Projection to i.svg": "32344786",
    "Right hand rule.svg": "32344787",
    "Strange star product drawn.svg": "32344788",
    "Strange star product.svg": "32344789",
    "Triangle.svg": "32344791",
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

#exercise(label: [Warm-Up])[
  Consider the dot product and my strange star product (component-wise multiplication):
  $
    chevron(4\, 0) dot chevron(sqrt(3)\, 2) = (4) (sqrt(3)) + (0) (2) = 4 sqrt(3), \
    chevron(4\, 0) star chevron(sqrt(3)\, 2) = chevron((4) (sqrt(3))\, (0) (2)) = chevron(4 sqrt(3)\, 0).
  $
  If we rotate the vectors by $30 degree$, we will get (I computed for you)
  $
    chevron(4\, 0) |-> chevron(2 sqrt(3)\, 2) quad "and" quad
    chevron(sqrt(3)\, 2) |-> chevron(1/2\, (3 sqrt(3))/2).
  $
  #figure(
    image(
      "Strange star product.svg",
      width: 50%,
      alt: "The original vectors in blue and the rotated vectors in red.",
    ),
    caption: "The original vectors in blue and the rotated vectors in red.",
  )
  Compute the dot product and my strange star product of the rotated vectors
  $
    chevron(2 sqrt(3)\, 2) dot chevron(1/2\, (3 sqrt(3))/2)
    quad "and" quad
    chevron(2 sqrt(3)\, 2) star chevron(1/2\, (3 sqrt(3))/2).
  $
  - Are the new and old dot products equal?
  - Are the new and old star products related by a $30 degree$ rotation?
]
#solution[
  The dot product of the rotated vectors is
  $
    chevron(2 sqrt(3)\, 2) dot chevron(1/2\, (3 sqrt(3))/2)
    = (2 sqrt(3)) (1/2) + (2) ((3 sqrt(3))/2)
    = sqrt(3) + 3 sqrt(3)
    = 4 sqrt(3),
  $
  which is the same as the dot product of the original vectors.
  The star product of the rotated vectors is
  $
    chevron(2 sqrt(3)\, 2) star chevron(1/2\, (3 sqrt(3))/2)
    = chevron((2 sqrt(3)) (1/2)\, (2) ((3 sqrt(3))/2))
    = chevron(sqrt(3)\, 3 sqrt(3)),
  $
  which is not the same as the star product of the original vectors and also not a $30 degree$ rotation of it.
  If we draw $chevron(sqrt(3)\, 3 sqrt(3))$, it will be even higher than the $chevron(sqrt(3)\, 2)$ vector, so the angle between the two start products is greater than $30 degree$.
  Even their lengths are different!
  We have
  $
    abs(chevron(4 sqrt(3)\, 0)) = 4 sqrt(3) approx 6.9 quad "and" quad
    abs(chevron(sqrt(3)\, 3 sqrt(3))) = sqrt(3 + 27) = sqrt(30) approx 5.5.
  $
  #figure(
    image(
      "Strange star product drawn.svg",
      width: 50%,
      alt: "The previous image with added yellow vectors having different lengths. One points in the direction of a blue vector, and the other points in a direction different from all other vectors.",
    ),
    caption: "The strange star products in yellow. They are not related at all.",
  )

  The key takeaway is that the dot product is geometric: *the choice of coordinates is irrelevant to dot product, we can find the dot product between two vectors by measuring their length and angle of separation.*

  In contrast, my strange star products are not geometric: if we are given two vectors without coordinates, we cannot compute the star product, and worse, if we will get different results if we choose two different coordinates to represent the vectors.
  You should never use my strange star product!
  (I see it on exams every time, and I hope I see it less!)
]

The reason why we love dot product and cross product is that (up to scaling) they are the only two distributive geometric operations involving vectors and scalars!

= Dot Product

I have foreshadowed that we can compute the dot product of two vectors in the air by measuring their lengths and the angle of separation.
Here is exactly how:
$
  arrow(u) dot arrow(v) = abs(arrow(u)) abs(arrow(v)) cos theta.
$
In words, the dot product of two vectors is the product of their lengths and the cosine of the angle between them.
Given the components of the vectors, we can also compute the dot product through
$
              chevron(u_1\, u_2) dot chevron(v_1\, v_2) & = u_1 v_1 + u_2 v_2, \
  chevron(u_1\, u_2\, u_3) dot chevron(v_1\, v_2\, v_3) & = u_1 v_1 + u_2 v_2 + u_3 v_3.
$

Dot product is especially interesting if one of the vectors is a unit vector (_i.e._ a vector of length $1$, a vector that lies on the unit circle if placed at the origin) because then the dot product is the length of the projection of the other vector onto the unit vector.
For example, given a vector $arrow(a) = chevron.l a_(1), a_(2), a_(3) chevron.r$, the (signed) length of the projection of $arrow(a)$ onto the unit vector $hat(i)$ pointing in the $x$-direction is simply $a_(1)$.
#figure(
  image(
    "Projection to i.svg",
    width: 40%,
    alt: "A gray line is drawn from the tip of vector a to the tip of the projection, forming a right angle with the projection.",
  ),
  caption: [
    The length of the projection of $arrow(a)$ onto $hat(i)$ is $a_(1)$.
  ],
)
This is codified in the dot product
$
  arrow(a) dot hat(i) = a_(1) = abs(arrow(a)) cos theta.
$
In this case, we also easily see that the two ways of computing the dot product are the same because
$
  cos theta = ("adjacent") / ("hypotenuse") = a_(1) / abs(arrow(a)) ==> abs(arrow(a)) cos theta = a_(1).
$
It is worth nothing that when $a_1$ is negative, then the angle $theta$ is obtuse (so $cos theta$ is negative), which is why the dot product with a unit vector is the _signed_ length of the projection (negative if the projection is in the opposite direction of the unit vector).

In general, the signed length of the projection of a vector $arrow(a)$ onto a vector $arrow(b)$ is given by
$
  abs(arrow(a)) cos theta = (arrow(a) dot arrow(b)) / abs(arrow(b))
$
and to find the projection vector, we simply do length times _direction_ of the vector $arrow(b)$
$
  op("proj")_(arrow(b)) (arrow(a)) = ((arrow(a) dot arrow(b)) / abs(arrow(b))) (arrow(b))/(abs(arrow(b))).
$
Note that direction is synonymous with unit vector, the direction of $arrow(b)$ means the unit vector $arrow(b) \/ abs(arrow(b))$.

#exercise[
  + Assume $abs(arrow(v)) = 2$ and $abs(arrow(u)) = 3$ and the angle between them is $pi/3$.
    - Find the dot product $arrow(v) dot arrow(u)$.
    - Find $abs(arrow(v) - 2 arrow(u))$. _Hint:_ $abs(arrow(v) - 2 arrow(u)) = sqrt((arrow(v) - 2 arrow(u)) dot (arrow(v) - 2 arrow(u)))$
    - _(Bonus)_ Give an example of two vectors $arrow(v) = chevron(...\, ...)$ and $arrow(u) = chevron(...\, ...)$ that satisfy the above conditions.
      Calculate $arrow(v) - 2 arrow(u)$ and its length.
  + Find the projection of $chevron(3\, 4\, 4)$ onto $chevron(2\, 1\, -1)$.
  + Find the projection of $chevron(3\, 4\, 4)$ onto the plane described by $2x + y - z = 0$ (the is the plane perpendicular to the vector $chevron(2\, 1\, -1)$ that passes through the origin).
]
#solution[
  + The dot product is
    $
      arrow(v) dot arrow(u) = abs(arrow(v)) abs(arrow(u)) cos theta = (2) (3) cos(pi/3) = 6 (1/2) = 3.
    $
    We have
    $
      abs(arrow(v) - 2 arrow(u))^2 &= (arrow(v) - 2 arrow(u)) dot (arrow(v) - 2 arrow(u)) \
      &= arrow(v) dot arrow(v) - 2 arrow(u) dot arrow(v) - 2 arrow(v) dot arrow(u) + 4 arrow(u) dot arrow(u) \
      &= abs(arrow(v))^2 - 4 (arrow(u) dot arrow(v)) + 4 abs(arrow(u))^2 quad "(the dot product is symmetric)"\
      &= 4 - 4 (3) + 4 (9) \
      &= 4 - 12 + 36 \
      &= 28.
    $
    Therefore, $abs(arrow(v) - 2 arrow(u)) = sqrt(28) = 2 sqrt(7)$.
    #tip[
      Note that the dot product is distributive, so $(arrow(a) - arrow(b)) dot arrow(c) = arrow(a) dot arrow(c) - arrow(b) dot arrow(c)$ for example.
    ]

    An example of two vectors that satisfy the conditions is $arrow(v) = chevron(1\, sqrt(3))$ and $arrow(u) = chevron(3\, 0)$.
    We have
    $
      arrow(v) - 2 arrow(u) = chevron(1\, sqrt(3)) - 2 chevron(3\, 0) = chevron(-5\, sqrt(3)) \
      ==> abs(arrow(v) - 2 arrow(u)) = sqrt((-5)^2 + (sqrt(3))^2) = sqrt(25 + 3) = sqrt(28) = 2 sqrt(7).
    $
  + We can find the length of projection of $chevron.l 3, 4, 4 chevron.r$ onto $chevron.l 2, 1, - 1 chevron.r$ by
    $
      chevron.l 3, 4, 4 chevron.r dot (chevron.l 2, 1, - 1 chevron.r)/(sqrt(6)) = frac(3 dot 2 + 4 dot 1 + 4 dot (- 1), sqrt(6)) = frac(6, sqrt(6)) = sqrt(6).
    $
    The projection of $chevron.l 3, 4, 4 chevron.r$ onto $chevron.l 2, 1, - 1 chevron.r$ is the length of projection multiplied by the unit vector pointing in the direction of $chevron.l 2, 1, - 1 chevron.r$, which is
    $
      sqrt(6) dot (chevron.l 2, 1, - 1 chevron.r)/(sqrt(6)) = chevron.l 2, 1, - 1 chevron.r .
    $
  + By examining the following picture, we see that the sum of the projection of $chevron.l 3, 4, 4 chevron.r$ onto a plane and the projection onto the normal vector of the plane should be $chevron.l 3, 4, 4 chevron.r$.
    In technical terms, a vector can always be decomposed into a component parallel to a vector and a component orthogonal to the vector.
    #figure(
      image(
        "Projection onto plane.svg",
        width: 50%,
        alt: "Two projections of a vector are orthogonal, and they form a rectangle whose diagonal is the original vector.",
      ),
      caption: [
        The projection of $chevron.l 3, 4, 4 chevron.r$ onto $chevron.l 2, 1, - 1 chevron.r$ plus the projection of $chevron.l 3, 4, 4 chevron.r$ onto the plane (in red) gives us back $chevron.l 3, 4, 4 chevron.r$.
      ],
    )

    Thus, the projection $arrow(v)$ of the vector $chevron.l 3, 4, 4 chevron.r$ onto the plane is given by
    $
      chevron.l 2, 1, - 1 chevron.r + arrow(v) = chevron.l 3, 4, 4 chevron.r .
    $
    Solving for $arrow(v)$ either by just thinking about it or doing subtraction gives us
    $
      arrow(v) = chevron.l 1, 3, 5 chevron.r .
    $
]

= Cross Product

Cross product between two vectors $arrow(a)$ and $arrow(b)$ calculates the area of the parallelogram described by $arrow(a)$ and $arrow(b)$ and the direction perpendicular to the parallelogram according to the right hand rule.

#figure(
  image(
    "Cross product.svg",
    width: 60%,
    alt: "Two vectors in the xy-plane and their cross product pointing in the z-direction.",
  ),
  caption: [
    The cross product of two vectors in the $x y$-plane is a vector in the $z$-direction, and the length of the cross product is the area of the parallelogram described by the two vectors.
  ],
)

For example in the above picture, we have
$
  3 hat(i) times (hat(i) + 2 hat(j)) = 6 hat(k)
$
because the parallelogram described by $3 hat(i)$ and $hat(i) + 2 hat(j)$ has area $6$ (base is $3$, height is $2$) and the direction perpendicular to the parallelogram is in the $z$-direction, and we should take the positive $hat(k)$ direction according to the right hand rule.
#figure(
  image(
    "Right hand rule.svg",
    width: 50%,
    alt: "A cap with two arrows drawn on it. One pointing to the bottom left labeled as a, and the other pointing to the bottom right labeled as b.",
  ),
  caption: [
    The right hand rule: imagine arrows as shown drawn on a cap on a water bottle.
    If we were to rotate the cap to turn $arrow(a)$ towards $arrow(b)$, we would uncap the water bottle, moving the cap up.
    Hence, the cross product $arrow(a) times arrow(b)$ points up.
  ],
)

In general, we can calculate the cross product of $arrow(a) = chevron.l a_(1), a_(2), a_(3) chevron.r$ and $arrow(b) = chevron.l b_(1), b_(2), b_(3) chevron.r$ by
$
  arrow(a) times arrow(b) = mat(delim: "|", hat(i), hat(j), hat(k); a_(1), a_(2), a_(3); b_(1), b_(2), b_(3)) .
$
For example, we can verify that
$
  3 hat(i) times (hat(i) + 2 hat(j)) = mat(delim: "|", hat(i), hat(j), hat(k); 3, 0, 0 ; 1, 2, 0) = hat(i) mat(delim: "|", 0, 0 ; 2, 0) - hat(j) mat(delim: "|", 3, 0 ; 1, 0) + hat(k) mat(delim: "|", 3, 0 ; 1, 2) = 6 hat(k) .
$
#tip[
  Remember that the way to calculate the determinant of a $2 times 2$ matrix is $mat(delim: "|", a, b ; c, d) = a d - b c$, that is the product of the main diagonal minus the product of the other diagonal.
]
#tip[
  We can also use cross product to find areas of shapes associated with parallelograms.
  For example, the area of the triangle described by $arrow(a)$ and $arrow(b)$ is half the area of the parallelogram described by $arrow(a)$ and $arrow(b)$, so
  $
    #text[Area of triangle described by] arrow(a) #text[and] arrow(b) = 1/2 abs(arrow(a) times arrow(b)) .
  $
  #figure(
    image(
      "Triangle.svg",
      width: 40%,
      alt: "A triangle and a parallelogram sharing the same base and height, the triangle is half of the parallelogram.",
    ),
    caption: [
      The area of the triangle is half of that of the parallelogram.
    ],
  )
]

Before we move on to exercises, let us briefly mention the idea of shapes as equations.
In 3-dimensional space, a surface corresponds to an equation and an equation corresponds to a surface.
For example, the $y z$-plane corresponds to the equation $x = 0$ because the condition for a point $(x, y, z)$ to be on the $x y$-plane is exactly that $x = 0$.
Say we want to know whether $(1, 0, 3)$ is on the $x y$-plane, we can simply check $1 =^? 0$, and the answer is no, so the point is not on the $x y$-plane.

As another example, when we see the equation $x^2 + y^2 = 1$, we should immediately recognize that it is _some_ surface in 3-dimensional space—it is the surface of a cylinder with radius $1$ whose axis is the $z$-axis.
If we want to know whether $(1, 0, 3)$ is on the surface, we can check $1^2 + 0^2 =^? 1$, and the answer is yes, so the point is on the surface.

The next level of this idea is that the intersection of two surfaces correspond to a pair of equations.
To check whether a point is on the intersection of two surfaces, we have to check whether it satisfies both equations.
For example, $(1, 0, 3)$ is not on the intersection of the surfaces $x^2 + y^2 = 1$ and $x = 0$ because it does not satisfy the second equation.

#tip[
  To "find" the intersection of two surfaces amounts to simplifying a pair of equations to a *pair* of simpler equations.
  Keep in mind that a pair of equations usually cannot be simplified into a single equation (it is analogous to saying that the intersection of two surfaces is usually not a surface).

  In the example above, we find that
  $
    cases(
      x^2 + y^2 = 1,
      x = 0
    ) <==> cases(
      y^2 = 1,
      x = 0
    ) <==> cases(
      y = 1 "or" y = -1,
      x = 0
    )
  $
  which tells us that points on the intersection are of the form $(0, 1, "anything")$ or $(0, -1, "anything")$.
  These draw out two lines which should make geometric sense by thinking about the cylinder along the $z$-axis and the $y z$-plane.

  It would be wrong to say that the pair of equations simplifies to a single equation $y^2 = 1$ because this will describe some surface (in fact, it will be two surfaces) and we know the intersection of the cylinder and the plane is not a surface.
]

#exercise[
  + Find a nonzero vector orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$.
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
    Is this vector related to your answer to part 1?
  + Consider the parallelepiped described by the vectors
    $
      arrow(a) = chevron.l 3, 0, 0 chevron.r, \
      arrow(b) = chevron.l 1, 2, 0 chevron.r, \
      arrow(c) = chevron.l 1, 1, 2 chevron.r .
    $
    With the parallelogram described by $arrow(a)$ and $arrow(b)$ as the base, find the height of the parallelepiped.
    Then, find the volume of the parallelepiped.
]
#solution[
  + We can find a nonzero vector orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$ by taking the cross product of the two vectors:
    $
      chevron.l 1, - 2, 1 chevron.r times chevron.l 2, 1, - 1 chevron.r = mat(delim: "|", hat(i), hat(j), hat(k); 1, - 2, 1 ; 2, 1, - 1) = hat(i) mat(delim: "|", - 2, 1 ; 1, - 1) - hat(j) mat(delim: "|", 1, 1 ; 2, - 1) + hat(k) mat(delim: "|", 1, - 2; 2, 1) = 1 hat(i) + 3 hat(j) + 5 hat(k) .
    $
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
    This is exactly the same vector we found in part 1!
    This is no coincidence because vectors parallel to the planes $x - 2 y + z = 0$ and $2 x + y - z = 5$ are orthogonal to $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$ respectively, so a vector parallel to the line of intersection should be orthogonal to both $chevron.l 1, - 2, 1 chevron.r$ and $chevron.l 2, 1, - 1 chevron.r$, so part 1 and part 2 are secretly the same question.
  + Exactly like the example of $3 hat(i) times (hat(i) + 2 hat(j)) = 6 hat(k)$, we have
    $
      arrow(a) times arrow(b) = mat(delim: "|", hat(i), hat(j), hat(k); 3, 0, 0 ; 1, 2, 0) = hat(i) mat(delim: "|", 0, 0 ; 2, 0) - hat(j) mat(delim: "|", 3, 0 ; 1, 0) + hat(k) mat(delim: "|", 3, 0 ; 1, 2) = 6 hat(k).
    $
    This tells us that the area of the parallelogram described by $arrow(a)$ and $arrow(b)$ is $abs(6 hat(k)) = 6$.
    Looking at the parallelepiped in the figure, we see that the height of the parallelepiped is exactly the $z$-component of $arrow(c)$, which is $2$.
    #figure(
      image(
        "Parallelepiped.svg",
        width: 80%,
        alt: "A parallelepiped with a base in the xy-plane.",
      ),
      caption: [
        The height of the parallelepiped is $2$.
      ],
    )
    Therefore, the volume of the parallelepiped is $6 times 2 = 12$.

    Note that we can have $arrow(c) = chevron("anything"\, "anything"\, 2)$ and the height of the parallelepiped will still be $2$.
    In general, the height of the parallelepiped is the length of the projection of $arrow(c)$ onto the direction that is perpendicular to the base, which is the direction of $arrow(a) times arrow(b)$.
    In symbols, this means that the height of the parallelepiped described by $arrow(a)$, $arrow(b)$, and $arrow(c)$ is (the absolute value of)
    $
      arrow(c) dot ( (arrow(a) times arrow(b)) / abs(arrow(a) times arrow(b)) ) .
    $
    The area of the base is $abs(arrow(a) times arrow(b))$, so the volume of the parallelepiped in general is (the absolute value of)
    $
      underbrace(arrow(c) dot ( (arrow(a) times arrow(b)) / abs(arrow(a) times arrow(b)) ), "height") underbrace(abs(arrow(a) times arrow(b)), "base") = arrow(c) dot (arrow(a) times arrow(b)) .
    $
    Kind of neat, don't you think?

    #tip[
      Do you see that
      $
        arrow(u) dot (arrow(v) times arrow(w)) = mat(delim: "|", u_(1), u_(2), u_(3); v_(1), v_(2), v_(3); w_(1), w_(2), w_(3)) ?
      $
      The geometric meaning of the determinant of a matrix is actually the volume of the parallelogram or the parallelepiped described by the rows (or columns) of the matrix!
    ]
]
