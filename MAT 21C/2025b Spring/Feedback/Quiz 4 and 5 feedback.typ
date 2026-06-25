#import "../Template/canvas-html.typ": *

Hi class,

Here are some common mistakes on quiz 4 and 5.
If you have specific questions, I encourage you to ask me in calc room.

- On quiz 4, it is important to know the difference between *order* and the number of terms.
  The order of a term in a power series is the exponent of #mi(`(x - a)`) in that term, so for example, #mi(`(x-1)^3`) is a term of order 3.
  When the question asks for the third-order Taylor polynomial, it is asking for all the terms up to and including the term of order 3, so the answer should be the sum of the terms of order 0, 1, 2, and 3.
  In general, the order might have little to do with the number of terms, for example
  #mitex(```
  x - \frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!}
  ```)
  is a seventh-order Taylor polynomial of #mi(`\sin x`), but it only has 4 terms.
- On quiz 5, I saw some answers that did not type check.
  Type checking here is just distinguishing between numbers and vectors.
  Remember that
  - Scalar multiplication *takes* a number and a vector and *outputs* a vector;
  - Dot product *takes* two vectors and *outputs* a number.
  This means that if we are calculating #mi(`\langle -2, 2, 1 \rangle \cdot \langle 3, 0, 4 \rangle`) and accidentally got #mi(`\langle -6, 0, 4 \rangle`), then we immediately know that this is wrong because the output of a dot product should be a number, not a vector.
  Similarly, if we want to scale the vector #mi(`\langle -2, 2, 1 \rangle`) by #mi(`2`), then #mi(`(2 \mathbf{i}) \langle -2, 2, 1 \rangle`) is not the correct notation because the inputs of scalar multiplication should be a number and a vector, not two vectors (knowing that #mi(`\mathbf{i}`) is a vector is also type checking).
- Lastly, the projection formula
  #mitex(```
  \operatorname{proj}_{\mathbf{v}} \mathbf{u} = \frac{\mathbf{u} \cdot \mathbf{v}}{\lvert \mathbf{v} \rvert^2} \mathbf{v}
  ```)
  is sometimes misstated in various ways.
  I like to remember the formula as
  #mitex(```
  \operatorname{proj}_{\mathbf{v}} \mathbf{u} = \underbrace{\left( \mathbf{u} \cdot \frac{\mathbf{v}}{\lvert \mathbf{v} \rvert} \right)}_{\text{length of proj}\quad} \frac{\mathbf{v}}{\lvert \mathbf{v} \rvert}
  ```)
  because I know dot product with unit vector is the length of the projection, and doing scalar multiplication with the unit vector in #mi(`\mathbf{v}`) gives us the projection onto #mi(`\mathbf{v}`).
  Another way to remember the formula is to think that the projection onto #mi(`\mathbf{v}`) points in the #mi(`\mathbf{v}`) direction, so the formula should be some scalar multiple of #mi(`\mathbf{v}`) and if we have two #mi(`\mathbf{v}`)'s in the numerator, then we should have two #mi(`\mathbf{v}`)'s in the denominator.
  This guarantees that the formula is independent of the length of #mi(`\mathbf{v}`), which the projection onto #mi(`\mathbf{v}`) should be.

Best,\
Chen

