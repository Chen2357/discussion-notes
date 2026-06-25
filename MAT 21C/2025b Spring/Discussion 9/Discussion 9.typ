#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "Contour.svg" : "31288733",
    "Contour solution.svg" : "31288731",
    "Gradient exercise.png" : "31288736",
    "One variable.svg" : "31288740",
    "Naive.png" : "31288737",
    "Exception.png" : "31288734",
  ),
  title: "MAT 21C Discussion 9",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 5, day: 26),
)

= Warm-Up

#exercise(label: [Warm-up])[
  Identify where along the trail (shown in blue) is the hiker's elevation the greatest (the level curves are shown in gray).
  #figure(
    image(
      "Contour.svg",
      width: 40%,
      alt: "Contour plot of a hill in the center, a wiggly trail in blue is on the west side of the hill going from south to north."
    )
  )
]
#solution[
  The hiker is at the greatest elevation at the red point in the following figure.
  The hiker reaches the elevation of around #mi(`220`) as seen by the level curve.
  #figure(
    image(
      "Contour solution.svg",
      width: 40%,
      alt: "The same plot as before, with a red point on where the trail is tangent to a level curve and some vectors in red perpendicular to the level curves."
    ),
    caption: [
      The red point is the highest point along the trail.
      Some gradient vectors are shown in red.
      Notice that they are all perpendicular to the level curves.
    ]
  )
  One way to describe the point is that it is where the trail is tangent to a level curve.
  After all, if the trail is crossing a level curve, then we are either going uphill or downhill, so we are not at the greatest elevation.
  Mathematically, such a point can be found by finding the gradient of the elevation function and solve for when the gradient is perpendicular to the velocity vector of the trail using the dot product.
  This works because the gradient is always perpendicular to the level curve, so if the velocity vector is perpendicular to the gradient, then it must be tangent to the level curve.
]

= Gradient

Recall that the difference #mi(`f(x + dx, y + dy) - f(x, y)`) for small #mi(`dx`) and #mi(`dy`) can be approximated by
#mitex(```
\frac{\partial f}{\partial x} dx + \frac{\partial f}{\partial y} dy = \left\langle \frac{\partial f}{\partial x}, \frac{\partial f}{\partial y} \right\rangle \cdot \langle dx, dy \rangle.
```)
We call the first vector in the dot product, the gradient of #mi(`f`), and we denote it by
#mitex(```
\nabla f = \left\langle \frac{\partial f}{\partial x}, \frac{\partial f}{\partial y} \right\rangle.
```)
Besides using it for approximation, it has two other geometric meanings.
+ The gradient points in the direction of the steepest increase, meaning that the directional derivative
  #mitex(```
  D_{\vec{u}} f = \nabla f \cdot \vec{u}
  ```)
  is the greatest among unit vectors #mi(`u`) precisely when #mi(`u`) points in the same direction as the gradient.
  The magnitude of the gradient is precisely the value of the greatest directional derivative.
+ The gradient of #mi(`f(x, y)`) is perpendicular to the level curves, and so it is a normal vector to the tangent line of the level curve.
  In particular, the tangent line to the level curve of #mi(`f(x, y)`) at #mi(`(x_0, y_0)`) is given by
  #mitex(```
  \nabla f (x_0, y_0) \cdot \langle x - x_0, y - y_0 \rangle = 0.
  ```)
  In #mi(`3`)-dimensions, the tangent plane to the level surface of #mi(`f(x, y, z)`) at #mi(`(x_0, y_0, z_0)`) is given by
  #mitex(```
  \nabla f (x_0, y_0, z_0) \cdot \langle x - x_0, y - y_0, z - z_0 \rangle = 0.
  ```)

#exercise[
  + Find the gradient of #mi(`f(x, y) = x^2 - xy + \frac{1}{2} y^2 + 3`).
    Then, evaluate #mi(`\nabla f (3, 2)`).
  + Verify that #mi(`(3, 2, 8)`) is on the surface #mi(`z = f(x, y)`) and find the equation for the tangent plane of the surface at that point. _Hint: the surface can also be written as #mi(`f(x, y) - z = 0`)._
  #figure(
    image(
      "Gradient exercise.png",
      width: 30%,
      alt: "A blue parabolic surface with a red point labeled (3, 2, 8) and a green plane tangent to the surface at that point."
    ),
    caption: [
      The surface #mi(`z = f(x, y)`) is shown in blue, and the tangent plane at #mi(`(3, 2, 8)`) is shown in green.
      (Image credit: figure 14.39 in the textbook.)
    ]
  )
  + Approximate the value of #mi(`f(3.01, 2.1)`), call it #mi(`L(3.01, 2.1)`).
  + The approximation you obtained in the previous part is called the *linear approximation*.
    The error #mi(`E(3.01, 2.1) = f(3.01, 2.1) - L(3.01, 2.1)`) is bounded by
    #mitex(```
    \lvert E(3.01, 2.1) \rvert \leq \frac{1}{2} M (\lvert 3.01 - 3 \rvert + \lvert 2.1 - 2 \rvert)^2
    ```)
    where #mi(`M`) must be an upper bound of #mi(`\lvert f_{xx} \rvert`), #mi(`\lvert f_{yy} \rvert`), and #mi(`\lvert f_{xy} \rvert`) for all points #mi(`3 \leq x \leq 3.01`) and #mi(`2 \leq y \leq 2.1`).
    Find the error bound.
]
#solution[
  + The gradient of #mi(`f(x, y)`) is
    #mitex(```
    \nabla f = \left\langle \frac{\partial f}{\partial x}, \frac{\partial f}{\partial y} \right\rangle = \langle 2x - y, -x + y \rangle.
    ```)
    Evaluating at #mi(`(3, 2)`), we get
    #mitex(```
    \nabla f (3, 2) = \langle 4, -1 \rangle.
    ```)
    #h(100%)
  + The point #mi(`(3, 2, 8)`) is on the surface #mi(`z = f(x, y)`) because
    #mitex(```
    f(3, 2) = 3^2 - 3 \cdot 2 + \frac{1}{2} \cdot 2^2 + 3 = 8.
    ```)
    We can find the tangent plane by finding the gradient of #mi(`f(x, y) - z`) which is
    #mitex(```
    \nabla (f(x, y) - z) = \langle 2x - y, -x + y, -1 \rangle.
    ```)
    Evaluating at #mi(`(3, 2, 8)`), we get the normal vector to the tangent plane
    #mitex(```
    \langle 4, -1, -1 \rangle.
    ```)
    Thus, the tangent plane is the plane perpendicular to #mi(`\langle 4, -1, -1 \rangle`) that passes through #mi(`(3, 2, 8)`), which is given by
    #mitex(```
    \langle 4, -1, -1 \rangle \cdot \langle x - 3, y - 2, z - 8 \rangle = 0.
    ```)
  + We can approximate the difference #mi(`f(3.01, 2.1) - f(3, 2)`) by the linear approximation
    #mitex(```
    \nabla f (3, 2) \cdot \langle 0.01, 0.1 \rangle = \langle 4, -1 \rangle \cdot \langle 0.01, 0.1 \rangle = -0.06.
    ```)
    Thus, we can approximate #mi(`f(3.01, 2.1)`) by
    #mitex(```
    L(3.01, 2.1) = f(3, 2) - 0.06 = 8 - 0.06 = 7.94.
    ```)
  + The second derivatives of #mi(`f`) are
    #mitex(```
    f_{xx} = 2, \quad f_{yy} = 1, \quad f_{xy} = -1.
    ```)
    Thus, we can take #mi(`M = 2`) as an upper bound for the second derivatives, and the error is bounded by
    #mitex(```
    \lvert E(3.01, 2.1) \rvert \leq \frac{1}{2} \cdot 2 \cdot (0.01 + 0.1)^2 = 0.0121.
    ```)
    This tells us that the actual value of #mi(`f(3.01, 2.1)`) is between #mi(`7.94 - 0.0121`) and #mi(`7.94 + 0.0121`).

    If you are curious, the actual value of #mi(`f(3.01, 2.1)`) is exactly #mi(`7.9441`).
    Our approximation is pretty close and our error bound is correct.
]

#tip[
  In general, the linear approximation of a function #mi(`f(x, y)`) at a point #mi(`(x_0, y_0)`) is given by
  #mitex(```
  L(x, y) = f(x_0, y_0) + \nabla f (x_0, y_0) \cdot \langle x - x_0, y - y_0 \rangle.
  ```)
  The error of the linear appximation on a rectangle containing #mi(`(x_0, y_0)`) is bounded by
  #mitex(```
  \lvert E(x, y) \rvert \leq \frac{1}{2} M (\lvert x - x_0 \rvert + \lvert y - y_0 \rvert)^2
  ```)
  where #mi(`M`) is an upper bound of the second derivatives of #mi(`f`) for all points in the rectangle.
]

= Second Derivative Test

If we want to find the extrema of a function #mi(`f(x)`) of one variable, we can find the critical points by solving #mi(`f'(x) = 0`), and then determine which critical points are local maxima or local minima by using the second derivative test.
To recap, the second derivative test for one variable says that:
- If #mi(`f''(x) > 0`), then the function is "happy" (curving upward), so the critical point is a local minimum.
- If #mi(`f''(x) < 0`), then the function is "sad" (curving downward), so the critical point is a local maximum.
#figure(
  image(
    "One variable.svg",
    width: 60%,
    alt: "Left graph showing a parabola that opens upward labeled f'' > 0. Right graph showing a parabola that opens downward labeled f'' < 0."
  ),
  caption: [
    The second derivative test for one variable.
  ]
)

For a function #mi(`f(x, y)`) of two variables, we can find the critical points by solving 
#mitex(```
f_x = 0 \quad \text{and} \quad f_y = 0.
```)
At critical points, the function is flat like the one variable case.
A naive classification of the critical points might be to just look at the second derivatives #mi(`f_{xx}`) and #mi(`f_{yy}`):
- A local maximum is curving downward in both directions, so we expect #mi(`f_{xx} < 0`) and #mi(`f_{yy} < 0`).
- A local minimum is curving upward in both directions, so we expect #mi(`f_{xx} > 0`) and #mi(`f_{yy} > 0`).
- If #mi(`f_{xx}`) and #mi(`f_{yy}`) have different signs, then the function is curving upward in one direction and curving downward in the other, so the critical point is a saddle point.
#figure(
  image(
    "Naive.png",
    width: 70%,
    alt: "Left graph showing a parabolic surface that opens downward. Middle graph showing a parabolic surface that opens upward. Right graph showing a saddle surface."
  ),
  caption: [
    Naive expectation of the second derivative test for two variables. (Image credit: #link("https://intellectualmathematics.com/dl/calculus.pdf")[Viktor Blåsjö])
  ]
)

This characterization is _almost complete_.
The fact that a surface is curving upward in both axes directions does not mean that it is curving upward in all directions: if it dips along the diagonal, then it is a sadle after all.
#figure(
  image(
    "Exception.png",
    width: 55%,
    alt: "A saddle surface with two parabolic curves along the x and y axes that open upward, but the surface dips along the diagonal."
  ),
  caption: [
    A surface with #mi(`f_{xx} > 0`) and #mi(`f_{yy} > 0`), but it is still a saddle point because it dips along the diagonal. (Image credit: #link("https://intellectualmathematics.com/dl/calculus.pdf")[Viktor Blåsjö])
  ]
)
To take the diagonal effect into account, the complete second derivative test for two variables look at the so-called *discriminant* #mi(`f_{xx} f_{yy} - f_{xy}^2`).
- If #mi(`f_{xx} f_{yy} - f_{xy}^2 > 0`) and #mi(`f_{xx} > 0`) (or #mi(`f_{yy} > 0`)), then the critical point is a local minimum.
- If #mi(`f_{xx} f_{yy} - f_{xy}^2 > 0`) and #mi(`f_{xx} < 0`) (or #mi(`f_{yy} < 0`)), then the critical point is a local maximum.
- If #mi(`f_{xx} f_{yy} - f_{xy}^2 < 0`), then the critical point is a saddle point.
- If #mi(`f_{xx} f_{yy} - f_{xy}^2 = 0`), the test is inconclusive.

#tip[
  Note that our naive classification is a special case of the discriminant test.
  - For local extrema, we have #mi(`f_{xx} f_{yy} - f_{x y}^2 > 0`) which can only happen when #mi(`f_{xx}`) and #mi(`f_{yy}`) have the same sign.
  - When #mi(`f_{xx}`) and #mi(`f_{yy}`) have different signs, we are gauranteed to have #mi(`f_{xx} f_{yy} - f_{xy}^2 < 0`), so it is a saddle point.
]

#exercise[
  + Find the critical point of #mi(`f(x, y) = x^2 - xy + \frac{1}{2} y^2 + 3`).
  + Determine whether the critical point is a local maximum, a local minimum, or a saddle point.
  + Find the critical points of #mi(`g(x, y) = 3y^2 - 2y^3 - 3x^2 + 6xy`).
  + Determine whether the critical points are local maxima, local minima, or saddle points.
]
#solution[
  + We have found in the previous exercise that
    #mitex(```
    \nabla f = \langle 2x - y, -x + y \rangle.
    ```)
    Setting the gradient to zero, we get
    #mitex(```
    2x - y = 0, \quad -x + y = 0.
    ```)
    Solving the system of equations, we get the critical point #mi(`(0, 0)`).
    #h(100%)
  + We have found the second derivatives of #mi(`f`) in the previous exercise, which are
    #mitex(```
    f_{xx} = 2, \quad f_{yy} = 1, \quad f_{xy} = -1.
    ```)
    Thus, we have
    #mitex(```
    f_{xx} f_{yy} - f_{xy}^2 = 2 \cdot 1 - (-1)^2 = 1 > 0,
    ```)
    and since #mi(`f_{xx} > 0`), the critical point is a local minimum.
  + We need to solve
    #mitex(```
    f_x = -6x + 6y = 0 \quad \text{and} \quad f_y = 6y - 6y^2 + 6x = 0.
    ```)
    From the first equation, we find #mi(`x = y`), and substition for #mi(`y`) into the second equation gives us
    #mitex(```
    - 6x^2 + 12 x = 0 \quad \text{or} \quad -6x (x - 2) = 0.
    ```)
    The solutions are #mi(`x = 0`) and #mi(`x = 2`), so the critical points are #mi(`(0, 0)`) and #mi(`(2, 2)`).
  + We calculate the second derivateives
    #mitex(```
    f_{xx} = -6, \quad f_{yy} = 6 - 12y, \quad f_{xy} = 6.
    ```)
    The disciminant is
    #mitex(```
    f_{xx} f_{yy} - f_{xy}^2 = -36 + 72 y - 36 = 72(y - 1).
    ```)
    - At the critical point #mi(`(0, 0)`), the discriminant is negative, so it is a saddle point.
    - At the critical point #mi(`(2, 2)`), the discriminant is positive, and since #mi(`f_{xx} < 0`), it is a local maximum.
]
