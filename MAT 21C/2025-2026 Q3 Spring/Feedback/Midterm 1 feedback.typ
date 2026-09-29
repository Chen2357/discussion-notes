#import "../Template/canvas-html.typ": *

Hi class,

Here are some general feedback for midterm 1 and quizzes 2 and 3.
Again if you have specific questions, I welcome you to ask me in calc room.
- In math, nothing can be discarded without a theorem backing it up.
  For example,
  #mitex(```
  \frac{n^2}{n^6 - 1} = \frac{n^2}{n^6} \tag{❌}
  ```)
  is as wrong as it can get in math because it is not true for any #mi(`n`).
  In engineering or practical sciences, saying that #mi(`n`) is so large that the #mi(`-1`) is negligible might as well be a valid argument, but we cannot do this in math.
  If you get the sense that something is negligible, then the test you are looking for is the *limit comparison test*, and just like that, you can back up your intuition with a rigorous theorem.
  You might that the unification of intuition with rigor extremely satisfying, I certainly do!
- There are some general mistakes in regards to application of theorems and deriving their conclusions.
  For example, I saw some incorrect applications of comparison and integral tests on alternating series (they can only be applied to positive series), and I also saw deriving absolute convergence from alternating series test (which does not tell us anything about absolute convergence).
  Besides just remembering the assumptions and conclusions of the theorems really well, I think it might help to draw pictures for the theorems.

  For example, comparison and integral tests only apply to positive series because they fundamentally rely on the idea that those series represent areas (I have a picture for the integral test in discussion 2).
  The picture for the alternating series did not make it into the discussion notes, but both Figure 10.15 and 10.16 in the textbook are really nice.
- Distinguish _sequence_ from _series_.
  For example, "#mi(`(1)^n`) converges" and "#mi(`\sum_{n=1}^\infty (1)^n`) diverges" are true statements, but if you left out the summation symbol, then the second statement would be false.
- Be sure be carry the limit and summation symbols across the equal sign.
  For example,
  #mitex(```
  \lim_{n\to \infty} \frac{\ln n}{n} = \frac{1/n}{1} = \frac{1}{n} = 0 \tag{❌}
  ```)
  is not correct.
  Again, #mi(`\frac{1}{n} = 0`) is as wrong as it can get because it is not true for any #mi(`n`).
  The correct way to write this is
  #mitex(```
  \lim_{n\to \infty} \frac{\ln n}{n} = \lim_{n\to \infty} \frac{1/n}{1} = \lim_{n\to \infty} \frac{1}{n} = 0.
  ```)
  Something tangential to this is the widespread misconception of "#mi(`=`)" as something that is operational rather than relations.
  It leads to so many instances where the answer is correct but the work is not.
  This #link("https://matheducators.stackexchange.com/questions/7964/issues-with-equals-where-does-this-come-from-and-how-do-i-combat-it")[discussion on math educators stack exchange] might be an interesting read if you do not know what I am talking about.
- Lastly, I want to say on quiz 3, many of us did not evaluate
  #mitex(```
  \lim_{n\to\infty} \frac{3\lvert x \rvert}{n + 1}
  ```)
  correctly (most common wrong answer is #mi(`3 \lvert x \rvert`)).
  If I ask you to evaluate
  #mitex(```
  \lim_{n\to\infty} \frac{3 \cdot 1}{n+1}, \quad \lim_{n\to\infty} \frac{3 \cdot 2}{n + 1}, \quad \text{or} \quad \lim_{n\to\infty} \frac{3 \cdot 3}{n + 1},
  ```)
  I bet all of you would correctly say that the answer is #mi(`0`).
  We have to be aware that #mi(`x`) is just a number, you might as well consider it an arabic numeral if you feel comfortable (so the arabic numerals are #mi(`0`), #mi(`1`), #mi(`2`), ..., #mi(`9`), and #mi(`x`)).

  This is a point I wanted to drive home in the last exercise of discussion 4.
  There was nothing special about #mi(`7`) in the proof for
  #mitex(```
  1 + 7 + \frac{7^2}{2!} + \frac{7^3}{3!} + \cdots = e^7.
  ```)
  Change it to #mi(`9`), we get the proof for
  #mitex(```
  1 + 9 + \frac{9^2}{2!} + \frac{9^3}{3!} + \cdots = e^9.
  ```)
  Change it to any positive #mi(`x`), we get the proof for
  #mitex(```
  1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots = e^x.
  ```)

Best,\
Chen
