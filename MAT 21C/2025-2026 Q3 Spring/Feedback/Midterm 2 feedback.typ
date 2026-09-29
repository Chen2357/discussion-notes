#import "../Template/canvas-html.typ": *

Hi class,

Here are some general feedback for midterm 2 and quiz 6 and 7.

- Be caureful to not write things like
  #mitex(```
  e^x = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24} \tag{❌}
  ```)
  because the left hand side is an exponential function while the right hand side is a polynomial, and it is wrong to say that they are equal.
  Always write ellipsis like
  #mitex(```
  e^x = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24} + \cdots \tag{✅}
  ```)
  when writing out Taylor series or introduce a name for the Taylor polynomial like
  #mitex(```
  P_4(x) = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \frac{x^4}{24} \tag{✅}
  ```)
  The warm-up question in Discussion 7 notes is an example where this mistake can lead to a wrong answer.
- Doing _type check_ on your answer is a really good way to catch mistakes.
  For example, if a question asks for parametric equations for a line, then our answer should be in the form
  #mitex(```
  x = x_0 + at, \quad y = y_0 + bt, \quad z = z_0 + ct.
  ```)
  If a question asks for the equation of a plane, then our answer should be in the form
  #mitex(```
  a (x - x_0) + b (y - y_0) + c (z - z_0) = 0 \quad \text{or} \quad ax + by + cz = d.
  ```)
  Type checking can also be used to spot mistakes mid solution.
  For example, if a solution is the cosine of a vector, then we immediately know that this is wrong because cosine takes a number as input, not a vector.
- On quiz 6, some of us tried to take the inverse of a vector when trying to find the direction vector.
  This is not correct because vectors do not have inverses (type checking would have caught this mistake).
  Every operation we learned have geometric meanings.
  Think about scalar-vector multiplication, vector addition, dot product, cross product, and vector magnitude.
  If we are doing an operation that has no geometric meaning in this class, then that is an indicator that we did something wrong.
- For quiz 7 question 2, many of us did not have the right notation for partial derivatives.
  I graded leniently this time, but this may not be the case in the future.
  The only two correct notations for partial derivatives are
  #mitex(```
  f_{x}, \quad f_{y}, \quad f_{xx}, \quad f_{xy}, \quad f_{yy}, \quad \text{etc.}
  ```)
  and
  #mitex(```
  \frac{\partial f}{\partial x}, \quad \frac{\partial f}{\partial y}, \quad \frac{\partial^2 f}{\partial x^2}, \quad \frac{\partial^2 f}{\partial x \partial y}, \quad \frac{\partial^2 f}{\partial y^2}, \quad \text{etc.}
  ```)
  Some incorrect notatations I saw include #mi(`f'(x)`), #mi(`\partial x`), #mi(`\partial^2 x`), #mi(`d'`), and various usage of primes.
  The prime notation is never used for partial derivatives.
  Also note that
  #mitex(```
  \frac{\partial f^2}{\partial x \partial y} \tag{❌}
  ```)
  is not correct.
  Remember that power often literally means writing the same thing multiple times, so #mi(`\partial f^2`) would mean #mi(`\partial f \partial f`), but taking second order partial derivative represents
  #mitex(```
  \frac{\partial}{\partial x} \left( \frac{\partial f}{\partial y} \right) = \frac{\partial^2 f}{\partial x \partial y}.
  ```)
  Note how there are two #mi(`\partial`) symbols in the numerator but only one #mi(`f`).

Best,\
Chen
