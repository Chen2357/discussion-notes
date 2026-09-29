#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "River.svg" : "31055233",
    "River2.svg" : "31055235",
    "River3.svg" : "31055236",
    "Vector.svg" : "31055239",
    "Addition.svg" : "31055230",
    "Subtraction.svg" : "31055238",
    "Scaling.svg" : "31055237",
    "Parallelogram.svg" : "31055232",
    "Parallelogram solution.svg" : "31055231",
  ),
  title: "MAT 21C Discussion 5",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 4, day: 28),
)

= Error Estimation

Recall Taylor's formula from the previous discussion.
#theorem(label: [Taylor's formula])[
  The remainder term
  #mitex(```
  R_n(x) = f(x) - \left( f(0) + f'(0) x + \frac{f''(0)}{2!} x^2 + \cdots + \frac{f^{(n)}(0)}{n!} x^n \right)
  ```)
  after approximating #mi(`f(x)`) by the Taylor polynomial of degree #mi(`n`) is bounded by
  #mitex(```
  \lvert R_n(x) \rvert \leq \frac{M}{(n+1)!} \lvert x \rvert^{n+1}
  ```)
  if #mi(`M`) is greater than or equal to #mi(`\lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`x`).
  For example, if #mi(`\lvert f^{(n+1)}(c) \rvert`) is increasing, then we can take #mi(`M = \lvert f^{(n+1)}(x) \rvert`).

  If we can show that
  #mitex(```
  \lim_{n \to \infty} \lvert R_n(x) \rvert \leq \lim_{n \to \infty} \frac{M}{(n+1)!} \lvert x \rvert^{n+1} = 0,
  ```)
  then we can conclude that the Taylor series converges to #mi(`f(x)`) at #mi(`x`).
  Be careful that #mi(`M`) is not always a constant, it can depend on #mi(`n`) or even #mi(`x`), so the limit #mi(`\lim_{n \to \infty} \frac{M}{(n+1)!} \lvert x \rvert^{n+1}`) might not be zero.
]
Last time, we used it to derive that
#mitex(```
1 + 7 + \frac{7^2}{2!} + \frac{7^3}{3!} + \frac{7^4}{4!} + \cdots = e^7
```)
which tells us that we can get the numerical value of #mi(`e^7`) with arbitrary precision by using more and more terms, but this begs the question: how many terms do we need to add to get a magnitude of error say less than #mi(`10^{-8}`)?

Thankfully, Taylor's formula also answers this question.
It tells us that the error if we approximate #mi(`e^7`) by the Taylor polynomial of degree #mi(`n`) is bounded by
#mitex(```
\lvert R_n(7) \rvert \leq \frac{M}{(n+1)!} 7^{n+1}
```)
where, as we discussed last week, we can pick #mi(`M = e^7`) because #mi(`e^7`) is greater than or equal to #mi(`\lvert f^{(n+1)}(c) \rvert = e^c`) for all #mi(`c`) between #mi(`0`) and #mi(`7`).
Therefore, the error using polynomial of degree #mi(`40`) for example is bounded by
#mitex(```
\lvert R_{40}(7) \rvert \leq \frac{e^7}{41!} 7^{41} \lesssim 1.462 \times 10^{-12}
```)
and by sheer luck, I got a number less than #mi(`10^{-8}`), so I can conclude that the Taylor polynomial of degree #mi(`40`) approximates #mi(`e^7`) with an error less than #mi(`10^{-8}`).
Under usual circumstances, we would need to find an #mi(`n`) that solves the inequality
#mitex(```
\lvert R_{n} (x) \rvert \leq \frac{M}{(n+1)!} \lvert x \rvert^{n+1} < 10^{-8}.
```)

#exercise[
  Consider the function #mi(`f(x) = \cos x`).
  + Use a fourth-order Taylor polynomial to approximate the value of #mi(`\cos(0.5)`).
  + Use Taylor's formula to estimate the error in your approximation.
  + Now use the fact that the Taylor series for #mi(`\cos x`) is alternating to find another estimation of the error.
    Which method gives a better estimation?
]
#solution[
  + The derivatives up to the fourth order are
    #mitex(```
    f(x) = \cos x, \quad f'(x) = -\sin x, \quad f''(x) = -\cos x, \quad f'''(x) = \sin x, \quad f^{(4)}(x) = \cos x.
    ```)
    Evaluating them at #mi(`0`) gives us
    #mitex(```
    f(0) = 1, \quad f'(0) = 0, \quad f''(0) = -1, \quad f'''(0) = 0, \quad f^{(4)}(0) = 1.
    ```)
    Therefore, the fourth-order Taylor polynomial is
    #mitex(```
    P_4(x) = 1 - \frac{x^2}{2!} + \frac{x^4}{4!}.
    ```)
    It is also useful to just remember that the Taylor series for #mi(`\cos x`) is an alternating series with only even powers of #mi(`x`), that is
    #mitex(```
    1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \frac{x^8}{8!} - \cdots.
    ```)
    Therefore, the approximation is
    #mitex(```
    P_4(0.5) = 1 - \frac{0.5^2}{2!} + \frac{0.5^4}{4!} = \frac{337}{384}.
    ```)
  + We have
    #mitex(```
    \lvert R_4(0.5) \rvert \leq \frac{M}{5!} 0.5^5
    ```)
    where we can pick #mi(`M = 1`) because #mi(`\lvert f^{(5)}(c) \rvert = \lvert -\sin c \rvert`) is less than or equal to #mi(`1`) for all #mi(`c`) between #mi(`0`) and #mi(`0.5`).
    Therefore, the error is bounded by
    #mitex(```
    \lvert R_4(0.5) \rvert \leq \frac{1}{5!} 0.5^5 \lesssim 0.000261.
    ```)
  + We shown in the previous discussion that the Taylor series for #mi(`\cos x`) does converge to #mi(`\cos x`), that is
    #mitex(```
    \cos x = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \cdots.
    ```)
    So we have
    #mitex(```
    \cos(0.5) = 1 - \frac{0.5^2}{2!} + \frac{0.5^4}{4!} - \frac{0.5^6}{6!} + \cdots = \sum_{n=0}^{\infty} \frac{(-1)^n}{2^{2n} (2n)!}.
    ```)
    Note that this is an alternating series and the terms #mi(`\frac{1}{2^{2n} (2n)!}`) are decreasing and converges to #mi(`0`), so we can apply the alternating series test estimation (Theorem 16 in Section 10.6 in the textbook) to say
    #mitex(```
    \lvert R_4(0.5) \rvert \leq \text{The absolute value of the next term in the series} = \frac{1}{2^6 6!} \lesssim 0.0000218.
    ```)
    We see that the alternating series test gives us a better estimation.
]


= Why We Study Vectors?

#exercise(label: [Discuss])[
  Suppose you are trying to go from location #mi(`A`) to location #mi(`B`) but you must stop by a river that is flowing in a straight line.
  How do you find the shortest path that does this?
  #figure(
    image(
      "River.svg",
      width: 60%,
      alt: "A blue horizontal line with red points A and B on the upper side and a gray path from A to the blue line and then to B."
    ),
    caption: [Is this the shortest path?]
  )
]
#solution[
  Imagine that there is a mirror image of the location #mi(`A`) on the other side of the river, which we will call #mi(`A'`).
  Note that each path from #mi(`A`) to #mi(`B`) that goes through the river corresponds to a path equal in length from #mi(`A'`) to #mi(`B`).
  Therefore, the shortest path should correspond to the straight path from #mi(`A'`) to #mi(`B`).
  Drawing the path and doing a reflection, we can obtain the shortest path from #mi(`A`) to #mi(`B`) that goes through the river.
  #figure(
    image(
      "River2.svg",
      width: 60%,
      alt: "Same as previous image with point A' which is the reflection of A across the blue line, a yellow path from A' to B that corresponds to the gray path, and a red path from A and A' to B."
    ),
    caption: [
      The yellow path shares the same length as the gray path.
      The shortest path and its corresponding path is drawn in red.
      We see that the corresponding path from A' to B is a straight line.
    ]
  )

  I think this is a extremely clever solution!
  It is so clever that I don't think I could come up with it and I find the idea hard to extrapolate to other problems.
  Luckily, mathematicians have developed the so-called "Lagrange multipliers" to solve this kind of optimization problems under constraints, and the perk is that it reveals just as much geometric insight and can be applied to a much wider range of problems.

  In fact, I can show you the idea right now.
  Imagine that the river is actually a rail and on the rail, there is a bead that can slide freely.
  We can put a string through point #mi(`A`), the bead, and point #mi(`B`).
  The shortest path will be revealed if we just pull the string tight.
  #figure(
    image(
      "River3.svg",
      width: 60%,
      alt: "A red dot on the blue line and a white path that coincides with the shortest path. Force vectors are drawn on the bead, two parallel to the white path and one perpendicular to the blue line."
    ),
    caption: [
      The red dot on the blue line represents the bead and the white path represents the string.
    ]
  )
  This path is the same as the one we found earlier.
  To see this, we think about the tension forces on the bead.
  There are two forces: one towards point #mi(`A`) and one towards point #mi(`B`).
  The total force must be perpendicular to the rail otherwise the bead would move, and this implies that the angles between each force vector and the rail must be the same, so reflecting a force vector across the rail will result in vectors pointing in opposite direction.
  This is the same geometric insight that was provided by the mirror image solution.

  The key insight of the Lagrange multiplier method is the idea that *something is equilibrium (think _optimal_) if the total force is perpendicular to the constraint.*
  Perhaps you can already imagine how this idea can be applied to various optimization problems such as finding the point on a parabola closest to a given point.
]

I hope that this discussion gives you some motivation for why we study vectors, and I want you to keep in mind that our ultimate goal for the second half of the course is to understand the Lagrange multiplier method.

= Vectors

In a 2-dimensional space, a vector is two numbers put in angle brackets such as #mi(`\vec{v} = \langle 8, 6 \rangle`).
A vector represents only a direction and a magnitude.
When we draw a vector, we have to choose a base point, but different choices of base points represent the same vector.
For example, the red vectors in the figure below both represent the same vector #mi(`\vec{v} = \langle 8, 6 \rangle`).
#figure(
  image(
    "Vector.svg",
    width: 40%,
    alt: "A grid with two red vectors with the same length and direction but different base."
  ),
  caption: [
    The two red vectors represent the same vector #mi(`\vec{v} = \langle 8, 6 \rangle = 8 \hat{i} + 6 \hat{j}`).
  ]
)
We can also write a vector in terms of the standard unit vectors #mi(`\hat{i}`) and #mi(`\hat{j}`) which are vectors with length 1 pointing in the cardinal directions, so the vector #mi(`\vec{v} = \langle 8, 6 \rangle`) can also be written as #mi(`8 \hat{i} + 6 \hat{j}`).

There are operations that we can do with vectors.
In this discussion, we will just talk about addition, subtraction, and scalar multiplication.
- To add vectors, we put them head to tail.
  Algebraically, we simply add the corresponding components, so for example, #mi(`\langle 1, 2 \rangle + \langle 3, 4 \rangle = \langle 4, 6 \rangle`).
  #figure(
    image(
      "Addition.svg",
      width: 30%,
      alt: "White arrows with the same base point labeled a and b. A red arrow from the base point to the opposite corner of the parallelogram formed by the white arrows labeled a + b."
    ),
    caption: [
      Addition of vectors.
    ]
  )
- There are two ways to think about #mi(`\vec{a} - \vec{b}`).
  One way is to think about it as the vector that when we add it to #mi(`\vec{b}`), we get #mi(`\vec{a}`).
  Another way is to think of it as adding #mi(`-\vec{b}`) (the vector with the same length as #mi(`\vec{b}`) but in the opposite direction) to #mi(`\vec{a}`).
  Algebraically, we can calculate it by subtracting the corresponding components, so for example, #mi(`\langle 1, 3 \rangle - \langle 3, 4 \rangle = \langle -2, -1 \rangle`).
  #figure(
    image(
      "Subtraction.svg",
      width: 30%,
      alt: "White arrows with the same base point labeled a and b. A red arrow from the tip of b to the tip of a labeled a - b."
    ),
    caption: [
      Two ways to subtract vectors.
    ]
  )
- To scale a vector by a number, we multiply the length of the vector by that number (direction will be flipped if negative).
  Algebraically, we can calculate it by multiplying each component by that number, so for example, #mi(`2 \langle 1, 3 \rangle = \langle 2, 6 \rangle`).
  #figure(
    image(
      "Scaling.svg",
      width: 50%,
      alt: "An arrow labeled a, an arrow half of the length labeled 1/2 a, and an arrow pointing in the opposite direction with the same length as a labeled -a."
    ),
    caption: [
      Scaling of vectors.
    ]
  )

#exercise(label: [Exercise])[
  #set list(spacing: 1em)
  If vectors #mi(`\vec{a}`) and #mi(`\vec{b}`) are drawn with the same base point, which of the following vectors correspond to the vector from the base point to the midpoint between the tips of #mi(`\vec{a}`) and #mi(`\vec{b}`)?
  #figure(
    image(
      "Parallelogram.svg",
      width: 30%,
      alt: "White arrows one labeled a pointing up and right and one labeled b pointing to the right. A red arrow labeled question mark."
    )
  )
  + #mi(`\frac{1}{2} (\vec{a} + \vec{b})`)
  + #mi(`\vec{a} + \frac{1}{2} (\vec{a} - \vec{b})`)
  + #mi(`\vec{b} + \frac{1}{2} (\vec{a} - \vec{b})`)
  + #mi(`\vec{a} - \frac{1}{2} (\vec{a} - \vec{b})`)
  + #mi(`\vec{b} + \frac{1}{2} (\vec{b} - \vec{a})`)
]
#solution[
  Expressions 1, 3, and 4 correspond to the vector from the base point to the midpoint of the segment between #mi(`\vec{a}`) and #mi(`\vec{b}`).
  The interpretation of #mi(`\frac{1}{2} (\vec{a} + \vec{b})`) is the half of the diagonal of the parallelogram shown in the vector addition figure.
    It is exactly the vector we want.
  The interpretation of the other expressions are shown in the figure below.
  #figure(
    image(
      "Parallelogram solution.svg",
      width: 30%,
      alt: "The previous figure with blue arrows labeled 1/2 (a - b) pointing up and left, one starting from the tip of a and one starting from the tip of b, and red arrows labeled 1/2 (b - a) pointing down and right, one starting from the tip of a and one starting from the tip of b."
    )
  )
]

// #exercise[
//   Let #mi(`\vec{a} = \langle 0, 1 \rangle`) and #mi(`\vec{b} = \langle 2, 1 \rangle`).
//   + Calculate and plot #mi(`\vec{a}`), #mi(`\vec{a} + \frac{\vec{b}}{2}`), and #mi(`\vec{a} + \vec{b}`), and #mi(`\vec{a} - \vec{b}`).
//     Can you explain why #mi(`\vec{a} + t \vec{b}`) generates a line as #mi(`t`) runs through all real numbers?
//     Draw the line.
//   + Find the vector pointing from each of the #mi(`4`) points you plotted to the point #mi(`\langle 1, 4 \rangle`).
//   + Which one of them is the closest to #mi(`\langle 1, 4 \rangle`)?
//     Is it the point closest to #mi(`\langle 1, 4 \rangle`) among all the points on line?
//     Why or why not?
// ]
// #solution[
//   + // TODO: picture
//     The points are #mi(`\vec{a} = \langle 0, 1 \rangle`), #mi(`\vec{a} + \frac{\vec{b}}{2} = \langle 1, \tfrac{3}{2} \rangle`), #mi(`\vec{a} + \vec{b} = \langle 2, 2 \rangle`), and #mi(`\vec{a} - \vec{b} = \langle -2, 0 \rangle`).
//   + The vectors pointing from the points to #mi(`\langle 1, 4 \rangle`) are #mi(`\langle 1, 3 \rangle`), #mi(`\langle 0, \tfrac{5}{2} \rangle`), #mi(`\langle -1, 2 \rangle`), and #mi(`\langle 3, 4 \rangle`) respectively.
//   + The point #mi(`\vec{a} + \vec{b} = \langle 2, 2 \rangle`) is the closest to #mi(`\langle 1, 4 \rangle`).
//     It is also the closest point on the line to #mi(`\langle 1, 4 \rangle`).
//     This is because the vector pointing from #mi(`\vec{a} + \vec{b}`) to #mi(`\langle 1, 4 \rangle`) is #mi(`\langle -1, 2 \rangle`), which is perpendicular to the line which is along the direction of #mi(`\vec{b} = \langle 2, 1 \rangle`).
//     We can show that they are perpendicular by calculating their dot product:
//     #mitex(```
//     \langle -1, 2 \rangle \cdot \langle 2, 1 \rangle = -1 \cdot 2 + 2 \cdot 1 = 0.
//     ```)
//     The reason why being perpendicular to the line implies that it is the closest point is by Pythagorean theorem.
// ]
