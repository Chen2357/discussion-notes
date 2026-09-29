#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "Cross product.svg": "31109435",
    "Offset.svg": "31109436",
    "Projection onto plane.svg": "31109438",
    "Projection to i.svg": "31109528",
    "Right hand rule.svg": "31109440",
    "Three dimensions solution.svg": "31109441",
    "Three dimensions.svg": "31109442",
    "Triangle.svg": "31109444",
  ),
  title: "MAT 21C Discussion 6",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 5, day: 5),
)

= Warm-Up

#exercise(label: [Warm-up])[
  Explain why #mi(`x = 0`) describes a plane in three-dimensional space and sketch the plane.
  #figure(
    image(
      "Three dimensions.svg",
      width: 40%,
      alt: "Three axes in three-dimensional space",
    ),
  )
]
#solution[
  A point is in the the region described by an equation (or equations) if the coordinates of the point satisfy the equation(s).
  For example, the point #mi(`(1, 0, 0)`) is not in the region because if we substitute #mi(`1`) for #mi(`x`) (and #mi(`0`) for #mi(`y`) and #mi(`z`) but they are not present in the equation), we get #mi(`1 = 0`), which is false.
  In contrast, the point #mi(`(0, 1, 1)`) is in the region because if we substitute #mi(`0`) for #mi(`x`), we get #mi(`0 = 0`), which is true.

  In general, a point is in the region described by #mi(`x = 0`) if the point lies in the #mi(`yz`)-plane (like #mi(`(0, 1, 1)`) and not in the region when it is not (like #mi(`(1, 0, 0)`)).
  Thus, the region described by #mi(`x = 0`) is the #mi(`yz`)-plane.
  #figure(
    image(
      "Three dimensions solution.svg",
      width: 40%,
      alt: "Three axes in three-dimensional space with the yz-plane shaded in red",
    ),
    caption: [
      The plane is the #mi(`yz`)-plane and is shaded in red.
    ],
  )
]

= Dot Product

Given a vector #mi(`\vec{a} = \langle a_1, a_2, a_3 \rangle`), the length of the projection of #mi(`\vec{a}`) onto the unit vector #mi(`\hat{i}`) pointing in the #mi(`x`)-direction is simply #mi(`a_1`).
#figure(
  image(
    "Projection to i.svg",
    width: 40%,
    alt: "A gray line is drawn from the tip of vector a to the tip of the projection, forming a right angle with the projection.",
  ),
  caption: [
    The length of the projection of #mi(`\vec{a}`) onto #mi(`\hat{i}`) is #mi(`a_1`).
  ],
)
This is codified in the dot product
#mitex(```
\vec{a} \cdot \hat{i} = a_1.
```)
The general definition of dot product is that
#mitex(```
\vec{a} \cdot \vec{b} = a_1 b_1 + a_2 b_2 + a_3 b_3,
```)
and we can verify that indeed
#mitex(```
\vec{a} \cdot \hat{i} = \langle a_1, a_2, a_3 \rangle \cdot \langle 1, 0, 0 \rangle = a_1 \cdot 1 + a_2 \cdot 0 + a_3 \cdot 0 = a_1.
```)
The geometric interpretation that dot product is the length of the projection still holds if we replace #mi(`\hat{i}`) with any other unit vector #mi(`\hat{u}`):
#mitex(```
\text{signed length of projection of } \vec{a} \text{ onto } \hat{u} = \vec{a} \cdot \hat{u} = \lvert \vec{a} \rvert \cos \theta
```)
where #mi(`\theta`) is the angle between #mi(`\vec{a}`) and #mi(`\hat{u}`) and the "signed" length is positive if the angle is acute and negative if the angle is obtuse.

Even when #mi(`\vec{b}`) is not a unit vector, we can still normalize #mi(`\vec{b}`) and get the formula
#mitex(```
\text{signed length of projection of } \vec{a} \text{ onto } \vec{b} = \vec{a} \cdot \frac{ \vec{b}}{\lvert \vec{b} \rvert} = \lvert \vec{a} \rvert \cos \theta
```)
where #mi(`\theta`) is now the angle between #mi(`\vec{a}`) and #mi(`\vec{b}`).

#tip[
  We can rearrange the above formula to get a symmetric form
  #mitex(```
  \vec{a} \cdot \vec{b} = \lvert \vec
  {a} \rvert \lvert \vec{b} \rvert \cos \theta.
  ```)
  This is useful when the question asks for the angle between two vectors.
]

An important consequence of the geometric understanding of the dot product is that two vectors #mi(`\vec{a}`) and #mi(`\vec{b}`) are orthogonal (length of projection is #mi(`0`)) precisely when #mi(`\vec{a} \cdot \vec{b} = 0`).

Another way to understand the warm-up question is that we can rewrite the equation #mi(`x = 0`) as #mi(`\langle x, y, z \rangle \cdot \langle 1, 0, 0 \rangle = 0`), which means that the plane described by #mi(`x = 0`) consists of all points whose displacement from the origin is orthogonal to #mi(`\langle 1, 0, 0 \rangle`).
In general, given a nonzero vector in three-dimensional space, the set of all points whose displacement from the origin is orthogonal to the vector forms a plane.

#exercise[
  + Which of the following points are on the plane described by #mi(`2 x + y - z = 5`)?
    - #mi(`(2, 1, -1)`)
    - #mi(`(2, 1, 0)`)
    - #mi(`(1, 3, 5)`)
  + Explain why #mi(`2x + y - z = 0`) describes a plane in three-dimensional space.
  + Explain why #mi(`2x + y - z = 5`) describes a plane in three-dimensional space.
  + Find the projection of #mi(`\langle 3, 4, 4 \rangle`) onto #mi(`\langle 2, 1, -1 \rangle`).
  + Find the projection of #mi(`\langle 3, 4, 4 \rangle`) onto the plane described by #mi(`2x + y - z = 0`).
]
#solution[
  + We can check if a point is on the plane by substituting the coordinates of the point into the equation of the plane and checking if the equation holds.
    - For #mi(`(2, 1, -1)`), we have #mi(`2 \cdot 2 + 1 \cdot 1 - (-1) = 6`), which is not equal to #mi(`5`), so #mi(`(2, 1, -1)`) is not on the plane.
    - For #mi(`(2, 1, 0)`), we have #mi(`2 \cdot 2 + 1 \cdot 1 - 0 = 5`), which is equal to #mi(`5`), so #mi(`(2, 1, 0)`) is on the plane.
    - For #mi(`(1, 3, 5)`), we have #mi(`2 \cdot 1 + 1 \cdot 3 - 5 = 0`), which is not equal to #mi(`5`), so #mi(`(1, 3, 5)`) is not on the plane.
  + We can rewrite the equation #mi(`2x + y - z = 0`) and #mi(`\langle x, y, z \rangle \cdot \langle 2, 1, -1 \rangle = 0`).
    This means that the plane described by #mi(`2x + y - z = 0`) consists of all points whose displacement from the origin is orthogonal to #mi(`\langle 2, 1, -1 \rangle`).
    Thus, the region described by #mi(`2x + y - z = 0`) is a plane.
  + We can rewrite the equation #mi(`2x + y - z = 5`) as #mi(`\langle x, y, z \rangle \cdot \langle 2, 1, -1 \rangle = 5`), but we do not really have a geometric interpretation for such equation yet.
    However, we can normalize the vector #mi(`\langle 2, 1, -1 \rangle`) by dividing both sides by the length #mi(`\lvert \langle 2, 1, -1 \rangle \rvert = \sqrt{2^2 + 1^2 + (-1)^2} = \sqrt{6}`) to get
    #mitex(```
    \langle x, y, z \rangle \cdot \frac{\langle 2, 1, -1 \rangle}{\sqrt{6}} = \frac{5}{\sqrt{6}}.
    ```)
    We do have a geometric interpretation for taking the dot product with a unit vector, and it is that the equation describes all the points whose displacement from the origin has a fixed length of projection onto the unit vector #mi(`\langle 2, 1, -1 \rangle`), and that fixed length is #mi(`5 / \sqrt{6}`).
    Drawing a picture reveals that these points form a plane.
    #figure(
      image(
        "Offset.svg",
        width: 40%,
        alt: "A plane and an orthogonal vector, the distance from the base of the vector to the their intersection is labeled as 5 / sqrt(6).",
      ),
      caption: [
        The vector #mi(`\langle 2, 1, -1 \rangle`) is drawn based at the origin, and the plane #mi(`2x + y - z = 5`) is shown in red and extends orthogonally out of the page.
      ],
    )
  + We can find the length of projection of #mi(`\langle 3, 4, 4 \rangle`) onto #mi(`\langle 2, 1, -1 \rangle`) by
    #mitex(```
    \langle 3, 4, 4 \rangle \cdot \frac{\langle 2, 1, -1 \rangle}{\sqrt{6}} = \frac{3 \cdot 2 + 4 \cdot 1 + 4 \cdot (-1)}{\sqrt{6}} = \frac{6}{\sqrt{6}} = \sqrt{6}.
    ```)
    Thus, the projection of #mi(`\langle 3, 4, 4 \rangle`) onto #mi(`\langle 2, 1, -1 \rangle`) is the length of projection multiplied by the unit vector pointing in the direction of #mi(`\langle 2, 1, -1 \rangle`), which is
    #mitex(```
    \sqrt{6} \cdot \frac{\langle 2, 1, -1 \rangle}{\sqrt{6}} = \langle 2, 1, -1 \rangle.
    ```)
  + By examining the following picture, we see that the sum of the projection of #mi(`\langle 3, 4, 4 \rangle`) onto a plane and the projection onto the normal vector of the plane should be #mi(`\langle 3, 4, 4 \rangle`).
    In technical terms, a vector can always be decomposed into a component parallel to a vector and a component orthogonal to the vector.
    #figure(
      image(
        "Projection onto plane.svg",
        width: 50%,
        alt: "Two projections of a vector are orthogonal, and they form a rectangle whose diagonal is the original vector.",
      ),
      caption: [
        The projection of #mi(`\langle 3, 4, 4 \rangle`) onto #mi(`\langle 2, 1, -1 \rangle`) (which is #mi(`\langle 2, 1, -1 \rangle`) in this case) plus the projection of #mi(`\langle 3, 4, 4 \rangle`) onto the plane (in red) gives us back #mi(`\langle 3, 4, 4 \rangle`).
      ],
    )

    Thus, the projection #mi(`\vec{v}`) of the vector #mi(`\langle 3, 4, 4 \rangle`) onto the plane is given by
    #mitex(```
    \langle 2, 1, -1 \rangle + \vec{v} = \langle 3, 4, 4 \rangle.
    ```)
    Solving for #mi(`\vec{v}`) either by just thinking about it or doing subtraction gives us
    #mitex(```
    \vec{v} = \langle 1, 3, 5 \rangle.
    ```)
]

= Cross Product

Cross product between two vectors #mi(`\vec{a}`) and #mi(`\vec{b}`) calculates the area of the parallelogram described by #mi(`\vec{a}`) and #mi(`\vec{b}`) and the direction perpendicular to the parallelogram according to the right hand rule.

#figure(
  image(
    "Cross product.svg",
    width: 60%,
    alt: "Two vectors in the xy-plane and their cross product pointing in the z-direction.",
  ),
  caption: [
    The cross product of two vectors in the #mi(`xy`)-plane is a vector in the #mi(`z`)-direction, and the length of the cross product is the area of the parallelogram described by the two vectors.
  ],
)

For example in the above picture, we have
#mitex(```
3 \hat{i} \times (\hat{i} + 2\hat{j}) = 6 \hat{k}
```)
because the parallelogram described by #mi(`3 \hat{i}`) and #mi(`\hat{i} + 2\hat{j}`) has area #mi(`6`) and the direction perpendicular to the parallelogram is in the #mi(`z`)-direction, and we should take the positive #mi(`\hat{k}`) direction according to the right hand rule.
#figure(
  image(
    "Right hand rule.svg",
    width: 50%,
    alt: "A cap with two arrows drawn on it. One pointing to the bottom left labeled as a, and the other pointing to the bottom right labeled as b.",
  ),
  caption: [
    The right hand rule: imagine arrows as shown drawn on a cap on a water bottle.
    If we were to rotate the cap to turn #mi(`\vec{a}`) towards #mi(`\vec{b}`), we would uncap the water bottle, moving the cap up.
    Hence, the cross product #mi(`\vec{a} \times \vec{b}`) points up.
  ],
)

In general, we can calculate the cross product of #mi(`\vec{a} = \langle a_1, a_2, a_3 \rangle`) and #mi(`\vec{b} = \langle b_1, b_2, b_3 \rangle`) by
#mitex(```
\vec{a} \times \vec{b} = \begin{vmatrix}
\hat{i} & \hat{j} & \hat{k} \\
a_1 & a_2 & a_3 \\
b_1 & b_2 & b_3
\end{vmatrix}.
```)
For example, we can verify that
#mitex(```
3 \hat{i} \times (\hat{i} + 2\hat{j}) = \begin{vmatrix}
\hat{i} & \hat{j} & \hat{k} \\
3 & 0 & 0 \\
1 & 2 & 0
\end{vmatrix}
=
\hat{i} \begin{vmatrix}
0 & 0 \\
2 & 0
\end{vmatrix}
-
\hat{j} \begin{vmatrix}
3 & 0 \\
1 & 0
\end{vmatrix}
+
\hat{k} \begin{vmatrix}
3 & 0 \\
1 & 2
\end{vmatrix}
= 6 \hat{k}.
```)
#tip[
  Remember that the way to calculate the determinant of a #mi(`2 \times 2`) matrix is #mi(`\begin{vmatrix} a & b \\ c & d \end{vmatrix} = ad - bc`), that is the product of the main diagonal minus the product of the other diagonal.
]
#tip[
  We can also use cross product to find areas of shapes associated with parallelograms.
  For example, the area of the triangle described by #mi(`\vec{a}`) and #mi(`\vec{b}`) is half the area of the parallelogram described by #mi(`\vec{a}`) and #mi(`\vec{b}`), so
  #mitex(```
  \text{Area of triangle described by } \vec{a} \text{ and } \vec{b} = \frac{1}{2} \lvert \vec{a} \times \vec{b} \rvert.
  ```)
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

#exercise[
  + One of the following points are in the the intersection of the planes described by #mi(`x - 2 y + z = 0`) and #mi(`2x + y - z = 5`).
    Find the point.
    Can you find another point in the intersection?
    - #mi(`(2, 1, 0)`)
    - #mi(`(0, 5, 10)`)
    - #mi(`(1, 3, 5)`)
  + Find a nonzero vector orthogonal to #mi(`\langle 1, -2, 1 \rangle`) and #mi(`\langle 2, 1, -1 \rangle`).
  + The intersection of the two planes in part 1 is a line.
    Find a nonzero vector parallel to the line.
  + Let #mi(`\vec{a} = \langle 0, 0, 2 \rangle`), #mi(`\vec{b} = \langle 1, -2, 1 \rangle`), and #mi(`\vec{c} = \langle 2, 1, -1 \rangle`).
    Verify that
    #mitex(```
    \vec{a} \cdot (\vec{b} \times \vec{c}) = \begin{vmatrix}
    0 & 0 & 2 \\
    1 & -2 & 1 \\
    2 & 1 & -1
    \end{vmatrix}.
    ```)
    Show that in general
    #mitex(```
    \vec{a} \cdot (\vec{b} \times \vec{c}) = \begin{vmatrix}
    a_1 & a_2 & a_3 \\
    b_1 & b_2 & b_3 \\
    c_1 & c_2 & c_3
    \end{vmatrix}
    ```)
    and give a geometric interpretation for the quantity #mi(`\vec{a} \cdot (\vec{b} \times \vec{c})`).
]
#solution[
  + We can check if a point is in the intersection of the two planes by substituting the coordinates of the point into the equations of the planes and checking if both equations hold.
    - For #mi(`(2, 1, 0)`), we have #mi(`2 - 2 \cdot 1 + 0 = 0`) and #mi(`2 \cdot 2 + 1 - 0 = 5`), so #mi(`(2, 1, 0)`) is in the intersection.
    - For #mi(`(0, 5, 10)`), we have #mi(`0 - 2 \cdot 5 + 10 = 0`) and #mi(`2 \cdot 0 + 5 - 10 = -5`), so #mi(`(0, 5, 10)`) is not in the intersection.
    - For #mi(`(1, 3, 5)`), we have #mi(`1 - 2 \cdot 3 + 5 = 0`) and #mi(`2 \cdot 1 + 3 - 5 = 0`), so #mi(`(1, 3, 5)`) is not in the intersection.
    The way I found the #mi(`(2, 1, 0)`) is by assuming that #mi(`z = 0`) and solve the remaining system of equations
    #mitex(```
    \begin{cases}
    x - 2 y = 0, \\
    2x + y = 5,
    \end{cases}
    ```)
    to get #mi(`x = 2`) and #mi(`y = 1`).
    We can find another point by assuming #mi(`z`) is another value or assuming #mi(`x`) or #mi(`y`) is another value and solving the system of equations again.
    For example, if we assume #mi(`x = 0`), then we can solve the system of equations
    #mitex(```
    \begin{cases}
    - 2 y + z = 0, \\
    y - z = 5,
    \end{cases}
    ```)
    to get #mi(`y = -5`) and #mi(`z = -10`), so #mi(`(0, -5, -10)`) is another point in the intersection (actually you could also guessed this because when we tried #mi(`(0, 5, 10)`), we got #mi(`0`) and #mi(`-5`) for the left hand sides).
  + We can find a nonzero vector orthogonal to #mi(`\langle 1, -2, 1 \rangle`) and #mi(`\langle 2, 1, -1 \rangle`) by taking the cross product of the two vectors:
    #mitex(```
    \langle 1, -2, 1 \rangle \times \langle 2, 1, -1 \rangle = \begin{vmatrix}
    \hat{i} & \hat{j} & \hat{k} \\
    1 & -2 & 1 \\
    2 & 1 & -1
    \end{vmatrix}
    =
    \hat{i} \begin{vmatrix}
    -2 & 1 \\
    1 & -1
    \end{vmatrix}
    -
    \hat{j} \begin{vmatrix}
    1 & 1 \\
    2 & -1
    \end{vmatrix}
    +
    \hat{k} \begin{vmatrix}
    1 & -2 \\
    2 & 1
    \end{vmatrix}
    =
    1 \hat{i} + 3 \hat{j} + 5 \hat{k}.
    ```)
  + We can find a nonzero vector parallel to the line by finding the difference between two points on the line of intersection.
    In part 1, we found the points #mi(`(2, 1, 0)`) and #mi(`(0, -5, -10)`) in the intersection, so we can take the difference to get
    #mitex(```
    \langle 2, 1, 0 \rangle - \langle 0, -5, -10 \rangle = \langle 2, 6 , 10 \rangle.
    ```)
    Note that this vector is pointing in the same direction as the vector we found in part 2.
    This is no coincidence because vectors parallel to the planes #mi(`x - 2y + z = 0`) and #mi(`2x + y - z = 5`) are orthogonal to #mi(`\langle 1, -2, 1 \rangle`) and #mi(`\langle 2, 1, -1 \rangle`) respectively, so a vector parallel to the line of intersection should be orthogonal to both #mi(`\langle 1, -2, 1 \rangle`) and #mi(`\langle 2, 1, -1 \rangle`), so part 2 and part 3 are secretly the same question.
  + We have already calculated that
    #mitex(```
    \vec{b} \times \vec{c} = \langle 1, -2, 1 \rangle \times \langle 2, 1, -1 \rangle = \langle 1, 3, 5 \rangle,
    ```)
    so we can calculate the left hand side of the equation by
    #mitex(```
    \vec{a} \cdot (\vec{b} \times \vec{c}) = \langle 0, 0, 2 \rangle \cdot \langle 1, 3, 5 \rangle = 10.
    ```)
    We can calculate the right hand side of the equation by
    #mitex(```
    \begin{vmatrix}
    0 & 0 & 2 \\
    1 & -2 & 1 \\
    2 & 1 & -1
    \end{vmatrix}
    =
    0 \begin{vmatrix}
    -2 & 1 \\
    1 & -1
    \end{vmatrix}
    -
    0 \begin{vmatrix}
    1 & 1 \\
    2 & -1
    \end{vmatrix}
    +
    2 \begin{vmatrix}
    1 & -2 \\
    2 & 1
    \end{vmatrix}
    =
    10.
    ```)
    Thus, we indeed have
    #mitex(```
    \vec{a} \cdot (\vec{b} \times \vec{c}) = \begin{vmatrix}
    0 & 0 & 2 \\
    1 & -2 & 1 \\
    2 & 1 & -1
    \end{vmatrix}
    ```)
    in this particular case.

    We can also show that this is generally true by computing
    #mitex(```
    \begin{aligned}
    \vec{a} \cdot (\vec{b} \times \vec{c}) &= (a_1 \hat{i} + a_2 \hat{j} + a_3 \hat{k}) \cdot \left(\hat{i} \begin{vmatrix} b_2 & b_3 \\ c_2 & c_3 \end{vmatrix} - \hat{j} \begin{vmatrix} b_1 & b_3 \\ c_1 & c_3 \end{vmatrix} + \hat{k} \begin{vmatrix} b_1 & b_2 \\ c_1 & c_2 \end{vmatrix}\right) \\
    &=
    a_1 \begin{vmatrix} b_2 & b_3 \\ c_2 & c_3 \end{vmatrix} - a_2 \begin{vmatrix} b_1 & b_3 \\ c_1 & c_3 \end{vmatrix} + a_3 \begin{vmatrix} b_1 & b_2 \\ c_1 & c_2 \end{vmatrix} \\
    &=
    \begin{vmatrix}
    a_1 & a_2 & a_3 \\
    b_1 & b_2 & b_3 \\
    c_1 & c_2 & c_3
    \end{vmatrix}.
    \end{aligned}
    ```)
    The geometric interpretation for the quantity #mi(`\vec{a} \cdot (\vec{b} \times \vec{c})`) is that it gives the signed volume of the parallelepiped described by #mi(`\vec{a}`), #mi(`\vec{b}`), and #mi(`\vec{c}`).
    The signed volume is negative if the direction of #mi(`\vec{b} \times \vec{c}`) (which we can find using right hand rule) is opposite to the direction of #mi(`\vec{a}`).
]
