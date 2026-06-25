#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
	course-id: "1067114",
	image-ids: (
		"Six possibilities.png" : "30976950"
	),
	title: "MAT 21C Discussion 4",
	author: "Chen Liang",
	date: datetime(year: 2026, month: 4, day: 21),
)

= Warm-Up

#exercise(label: [Discuss])[
	Consider a power series
	#mitex(```
	c_0 + c_1 x + c_2 x^2 + c_3 x^3 + c_4 x^4 + \cdots.
	```)
	Discuss what the phrase "the power series converges at #mi(`x = a`)" means if #mi(`a`) is a constant.
	If the series converges absolutely at #mi(`x = a`), then what can we say about the convergence of the series at #mi(`x = -a`)?
	Does your argument work for negative #mi(`a`) as well?
]
#solution[
	The power series converges at #mi(`x = a`) if the series
	#mitex(```
	c_0 + c_1 a + c_2 a^2 + c_3 a^3 + c_4 a^4 + \cdots
	```)
	converges.
	Note that #mi(`c_n`) and #mi(`a`) are just constants, so the series is just an infinite sum of numbers.
	If the series converges absolutely at #mi(`x = a`), then that means the series
	#mitex(```
	\lvert c_0 \rvert + \lvert c_1 a \rvert + \lvert c_2 a^2 \rvert + \lvert c_3 a^3 \rvert + \lvert c_4 a^4 \rvert + \cdots = S
	```)
	converges to some finite number #mi(`S`).
	Whether or not the series converges at #mi(`x = -a`) depends on whether the series
	#mitex(```
	c_0 + c_1 (-a) + c_2 (-a)^2 + c_3 (-a)^3 + c_4 (-a)^4 + \cdots,
	```)
	but then we know
	#mitex(```
	\lvert c_0 \rvert + \lvert c_1 (-a) \rvert + \lvert c_2 (-a)^2 \rvert + \lvert c_3 (-a)^3 \rvert + \lvert c_4 (-a)^4 \rvert + \cdots = S,
	```)
	so the series converges absolutely at #mi(`x = -a`) by the absolute convergence test.
]

= Power Series

Recall the very first discussion where I showed you the Taylor series for #mi(`\cos x`) which is
#mitex(```
\cos x = 1 - \frac{x^2}{2} + \frac{x^4}{24} - \frac{x^6}{720} + \cdots = \sum_{n=0}^\infty \frac{(-1)^n x^{2n}}{(2n)!}.
```)
This is one of the tools to calculate #mi(`\cos x`) and get the computer to show you a number with finite precision on screen.
The computer can not calculate the theoretical value of say #mi(`\cos 0.01`) because it would involve infinitely many calculations and the ability to show infinitely many digits.

There are two questions that need to be answered to be confident about this method.
- What is the interval of convergence of the power series?
- Does the power series converge to our target function on the interval of convergence?
Only if we have the answers to these two questions, we can be sure that the power series is a valid method to calculate the function.

#theorem[
	There are only six possibilities for the interval of convergence of a power series
	#mitex(```
	c_0 + c_1 (x - a) + c_2 (x - a)^2 + c_3 (x - a)^3 + c_4 (x - a)^4 + \cdots
	```)
	determined by the radius of convergence #mi(`R`) and the convergence behaviors at the endpoints #mi(`a - R`) and #mi(`a + R`).
	#figure(
		image(
			"Six possibilities.png",
			width: 50%
		),
		caption: [Six possibilities for the interval of convergence of a power series.]
	)
	Moreover, the series always converges absolutely on the interior of the interval of convergence.
	As suggested by the warm-up, absolute convergence is symmetric about the center.

	Finding the interval of convergence consists of three steps:
	1. Apply the ratio or root test (or other methods that shows _absolute convergence_), so we are looking at the absolute convergence condition
		#mitex(```
		\lim_{n \to \infty} \left\lvert \frac{(n+1)\text{th term}}{n\text{th term}} \right\rvert < 1 \quad \text{or} \quad \lim_{n \to \infty} \sqrt[n]{\lvert n\text{th term} \rvert} < 1.
		```)
	2. There are three different possibilities at this point.
    - The absolute convergence condition can be true for all #mi(`x`), then #mi(`R = \infty`) and the interval of convergence is #mi(`(-\infty, \infty)`).
    - The absolute convergence condition can be only true for #mi(`x = a`), then #mi(`R = 0`) and the interval of convergence is #mi(`\{a\}`).
    - The absolute convergence condition can be rewritten as
      #mitex(```
      \lvert x - a \rvert < R
      ```)
      and #mi(`R`) would be the radius of convergence.
      Further analysis is needed to determine the convergence behaviors at the endpoints #mi(`a - R`) and #mi(`a + R`).
	3. Check for the convergence at the endpoints by plugging in #mi(`x = a - R`) and #mi(`x = a + R`), which is to say, we need to decide whether the series
    #mitex(```
    \begin{aligned}
    \text{at } x = a - R &: c_0 + c_1 (-R) + c_2 (-R)^2 + c_3 (-R)^3 + c_4 (-R)^4 + \cdots \\
    \text{at } x = a + R &: c_0 + c_1 R + c_2 R^2 + c_3 R^3 + c_4 R^4 - \cdots
    \end{aligned}
    ```)
    converges or diverges.
		We will conclude one of the four possibilities for the interval of convergence: #mi(`(a - R, a + R)`), #mi(`[a - R, a + R)`), #mi(`(a - R, a + R]`), or #mi(`[a - R, a + R]`).
]

As an example, let us find the interval of convergence of the power series
#mitex(```
1 - x^2 + x^4 - x^6 + x^8 - x^{10} + \cdots = \sum_{n=0}^\infty (-1)^n x^{2n}.
```)
One way is to notice that this is a geometric series with common ratio #mi(`-x^2`) so it converges absolutely if and only if #mi(`\lvert -x^2 \rvert < 1`) which can be rewritten as #mi(`\lvert x \rvert < 1`).
Applying the ratio test gives the same condition:
#mitex(```
\lim_{n \to \infty} \left\lvert \frac{(-1)^{n+1} x^{2(n+1)}}{(-1)^n x^{2n}} \right\rvert = \lim_{n \to \infty} \lvert x^2 \rvert = \lvert x \rvert^2 < 1 \iff \lvert x \rvert < 1.
```)
Therefore, the radius of convergence is #mi(`R = 1`).
Now, we need to check for convergence at the endpoints #mi(`x = -1`) and #mi(`x = 1`).
At #mi(`x = -1`), the series becomes
#mitex(```
1 - 1 + 1 - 1 + 1 - 1 + \cdots
```)
which diverges, and at #mi(`x = 1`), the series also becomes
#mitex(```
1 - 1 + 1 - 1 + 1 - 1 + \cdots
```)
which diverges.
Therefore, the interval of convergence is #mi(`(-1, 1)`).

#exercise[
	#set enum(spacing: 1.5em)
	Find the interval of convergence of the following power series.
	+ #mi(`\displaystyle 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!} + \cdots`)
	+ #mi(`\displaystyle x - \frac{x^3}{3} + \frac{x^5}{5} - \frac{x^7}{7} + \frac{x^9}{9} - \cdots`)
]
#solution[
	+ The series can be rewritten as
    #mitex(```
    \sum_{n=0}^\infty \frac{x^n}{n!}.
    ```)
		By the ratio test, the series converges absolutely if
	  #mitex(```
	  \lim_{n\to\infty} \left\lvert \frac{x^{n+1}}{(n+1)!} \frac{n!}{x^n} \right\rvert = \lim_{n\to\infty} \left\lvert \frac{x}{n+1} \right\rvert = 0 < 1,
	  ```)
    which is true for all #mi(`x`).
    Therefore, the interval of convergence is #mi(`(-\infty, \infty)`).
    #h(100%)
	+ The series can be rewritten as
    #mitex(```
    \sum_{n=0}^\infty \frac{(-1)^n x^{2n+1}}{2n+1}.
    ```)
    By the ratio test, the series converges absolutely if
    #mitex(```
    \lim_{n\to\infty} \left\lvert \frac{(-1)^{n+1} x^{2(n+1)+1}}{2(n+1)+1} \cdot \frac{2n+1}{(-1)^n x^{2n+1}} \right\rvert = \lim_{n\to\infty} \left\lvert \frac{2n+1}{2n + 3} x^2 \right\rvert = \lim_{n\to\infty} \left\lvert \frac{2+1/n}{2 + 3/n} x^2 \right\rvert = x^2 < 1.
    ```)
    This can be rewritten as #mi(`\lvert x \rvert < 1`), so the radius of convergence is #mi(`R = 1`).
    We need to check for convergence at the endpoints #mi(`x = -1`) and #mi(`x = 1`).
    At #mi(`x = -1`), the series becomes
    #mitex(```
    -1 + \frac{1}{3} - \frac{1}{5} + \frac{1}{7} - \frac{1}{9} + \cdots,
    ```)
    which converges by the alternating series test because #mi(`\left( 1, \frac{1}{3}, \frac{1}{5}, \frac{1}{7}, \cdots \right)`) is a positive decreasing sequence that converges to #mi(`0`).
    Therefore, the interval of convergence includes #mi(`-1`).
    At #mi(`x = 1`), the series becomes
    #mitex(```
    1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \cdots,
    ```)
    which also converges by the alternating series test.
    Therefore, the interval of convergence is #mi(`[ - 1, 1 ]`).
]

While we know that the series
#mitex(```
1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \cdots
```)
converges, we do not know what it converges to.
Taylor series is a tool that can help us answer this question.
In Professor's discussion worksheet, you will be guided to find that
#mitex(```
\arctan x = x - \frac{x^3}{3} + \frac{x^5}{5} - \frac{x^7}{7} + \frac{x^9}{9} - \cdots
```)
for #mi(`-1 \leq x \leq 1`) and thus we get the amazing formula
#mitex(```
\frac{\pi}{4} = \arctan 1 = 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \cdots
```)
by plugging in #mi(`x = 1`).

= Taylor Series

We begin with the question whether we can rewrite a target function #mi(`f(x)`) as a power series
#mitex(```
c_0 + c_1 x + c_2 x^2 + c_3 x^3 + c_4 x^4 + \cdots.
```)
We can obtain a "best guess" by matching all orders of derivatives at #mi(`x = 0`), and this best guess is called the Taylor series of #mi(`f(x)`) generated at #mi(`x = 0`).
It is given by
#mitex(```
p(x) = f(0) + f'(0) x + \frac{f''(0)}{2 \cdot 1} x^2 + \frac{f^{(3)}(0)}{3 \cdot 2 \cdot 1} x^3 + \frac{f^{(4)}(0)}{4 \cdot 3 \cdot 2 \cdot 1} x^4 + \cdots = \sum_{n=0}^\infty \frac{f^{(n)}(0)}{n!} x^n.
```)
We can convince ourselves that this power series matches all orders of derivatives at #mi(`x = 0`) by checking that
#mitex(```
\begin{aligned}
p(x) &= f(0) + f'(0) x + \frac{f''(0)}{2 \cdot 1} x^2 + \frac{f^{(3)}(0)}{3 \cdot 2 \cdot 1} x^3 + \frac{f^{(4)}(0)}{4 \cdot 3 \cdot 2 \cdot 1} x^4 + \cdots &&\implies p(0) = f(0)\\
p'(x) &= f'(0) + \frac{f''(0)}{1} x + \frac{f^{(3)}(0)}{2 \cdot 1} x^2 + \frac{f^{(4)}(0)}{3 \cdot 2 \cdot 1} x^3 + \cdots &&\implies p'(0) = f'(0)\\
p''(x) &= f''(0) + \frac{f^{(3)}(0)}{1} x + \frac{f^{(4)}(0)}{2 \cdot 1} x^2 + \cdots &&\implies p''(0) = f''(0)\\
\, & \; \vdots && \;\; \vdots
\end{aligned}
```)
We can generalize this definition to Taylor series generated by any point #mi(`x = a`) instead of #mi(`x = 0`), and the formula is
#mitex(```
f(a) + f'(a) (x - a) + \frac{f''(a)}{2!} (x - a)^2 + \frac{f^{(3)}(a)}{3!} (x - a)^3 + \cdots = \sum_{n=0}^\infty \frac{f^{(n)}(a)}{n!} (x - a)^n.
```)
// For the sake of simplicity, we will only talk about Taylor series generated at #mi(`x = 0`) in this discussion.

The Taylor series is only a best guess.
It is only sometimes true that the Taylor series converges to the target function.
We need to verify it using the Taylor's formula.
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

As an example, the taylor series of #mi(`f(x) = e^x`) is (using the fact that #mi(`f^{(n)}(x) = e^x`) and thus #mi(`f^{(n)}(0) = 1`))
#mitex(```
1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!} + \cdots.
```)
We know that the series converges for all #mi(`x`) from the previous exercise, but does it converge to #mi(`e^x`)?
This is what is going to be answered by the Taylor's formula.

I will show that
#mitex(```
1 + 7 + \frac{7^2}{2!} + \frac{7^3}{3!} + \frac{7^4}{4!} + \cdots = e^7,
```)
which is to say that the taylor series converges to #mi(`e^7`) at #mi(`x = 7`).
(Note that no convergence test can tell us what the series #mi(`1 + 7 + \frac{7^2}{2!} + \frac{7^3}{3!} + `) converges to!)
The remainder at #mi(`x = 7`) is
#mitex(```
R_n (7) = e^7 - \left( 1 + 7 + \frac{7^2}{2!} + \frac{7^3}{3!} + \cdots + \frac{7^n}{n!} \right)
```)
which is bounded by
#mitex(```
\lvert R_n(7) \rvert \leq \frac{M}{(n+1)!} 7^{n+1}
```)
if we can find #mi(`M`) such that #mi(`M \geq \lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`7`).
Since #mi(`f^{(n+1)}(c) = e^c`) is increasing, we can take #mi(`M = e^7`).
Therefore, we have
#mitex(```
\lvert R_n(7) \rvert \leq \frac{e^7}{(n+1)!} 7^{n+1}.
```)
By item 6 in Theorem 5 in Section 10.1 of the textbook (the proper statement of what it means for #mi(`x^n`) to grow slower than #mi(`n!`)), we have
// #mitex(```
// \lim_{n \to \infty} \left\lvert \frac{e^7 \cdot 7^{n+2}}{(n+2)!} \cdot \frac{(n+1)!}{e^7 \cdot 7^{n+1}} \right\rvert = \lim_{n \to \infty} \frac{7}{n+2} = 0 < 1,
// ```)
// so then
#mitex(```
\lim_{n \to \infty} \lvert R_n(7) \rvert \leq \lim_{n \to \infty} \frac{e^7}{(n+1)!} 7^{n+1} = 0,
```)
and we conclude that the Taylor series converges to #mi(`e^7`) at #mi(`x = 7`).

#exercise[
	+ Show that the Taylor series of #mi(`e^x`) converges to #mi(`e^9`) at #mi(`x = 9`). (Skip if you feel this is too easy)
	+ Show that the Taylor series of #mi(`e^x`) converges to #mi(`e^x`) for all #mi(`x > 0`).
	+ Show that the Taylor series of #mi(`e^x`) converges to #mi(`e^x`) for all #mi(`x < 0`).
	+ Find the Taylor series of #mi(`\cos x`) and show that it converges to #mi(`\cos x`) for all #mi(`x`).
]
#solution[
  + (The solution is simply replacing #mi(`7`) with #mi(`9`) in the previous example)

    The remainder at #mi(`x = 9`) is
    #mitex(```
    R_n (9) = e^9 - \left( 1 + 9 + \frac{9^2}{2!} + \frac{9^3}{3!} + \cdots + \frac{9^n}{n!} \right)
    ```)
    which is bounded by
    #mitex(```
    \lvert R_n(9) \rvert \leq \frac{M}{(n+1)!} 9^{n+1}
    ```)
    if we can find #mi(`M`) such that #mi(`M \geq \lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`9`).
    Since #mi(`f^{(n+1)}(c) = e^c`) is increasing, we can take #mi(`M = e^9`).
    Therefore, we have
    #mitex(```
    \lvert R_n(9) \rvert \leq \frac{e^9}{(n+1)!} 9^{n+1}.
    ```)
    By Theorem 5 in Section 10.1 of the textbook, we have
    // #mitex(```
    // \lim_{n \to \infty} \left\lvert \frac{e^9 \cdot 9^{n+2}}{(n+2)!} \cdot \frac{(n+1)!}{e^9 \cdot 9^{n+1}} \right\rvert = \lim_{n \to \infty} \frac{9}{n+2} = 0 < 1,
    // // ```)
    // so then
    #mitex(```
    \lim_{n \to \infty} \lvert R_n(9) \rvert \leq \lim_{n \to \infty} \frac{e^9}{(n+1)!} 9^{n+1} = 0,
    ```)
    and we can conclude that the Taylor series converges to #mi(`e^9`) at #mi(`x = 9`).

  + The above argument can be used to prove that the Taylor series of #mi(`e^x`) converges to #mi(`e^5`) at #mi(`x = 5`), to #mi(`e^6`) at #mi(`x = 6`), to #mi(`e^{100}`) at #mi(`x = 100`), and in fact to #mi(`e^x`) at any positive #mi(`x`).
    We simply need to replace #mi(`9`) with the positive #mi(`x`) in the above argument.

    The remainder is
    #mitex(```
    R_n (x) = e^x - \left( 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots + \frac{x^n}{n!} \right)
    ```)
    which is bounded by
    #mitex(```
    \lvert R_n(x) \rvert \leq \frac{M}{(n+1)!} \lvert x \rvert^{n+1}
    ```)
    if we can find #mi(`M`) such that #mi(`M \geq \lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`x`).
    Since #mi(`f^{(n+1)}(c) = e^c`) is increasing, we can take #mi(`M = e^x`).
    Therefore, we have
    #mitex(```
    \lvert R_n(x) \rvert \leq \frac{e^x}{(n+1)!} \lvert x \rvert^{n+1}.
    ```)
    By Theorem 5 in Section 10.1 of the textbook, we have
    // #mitex(```
    // \lim_{n \to \infty} \left\lvert \frac{e^x \cdot \lvert x \rvert^{n+2}}{(n+2)!} \cdot \frac{(n+1)!}{e^x \cdot \lvert x \rvert^{n+1}} \right\rvert = \lim_{n \to \infty} \frac{\lvert x \rvert}{n+2} = 0 < 1,
    // ```)
    // so then
    #mitex(```
    \lim_{n \to \infty} \lvert R_n(x) \rvert \leq \lim_{n \to \infty} \frac{e^x}{(n+1)!} \lvert x \rvert^{n+1} = 0,
    ```)
    and we can conclude that the Taylor series converges to #mi(`e^x`) at #mi(`x`) for all #mi(`x > 0`).

  + There is a caveat in the above argument when #mi(`x < 0`) because #mi(`e^x`) is no longer the maximum of #mi(`\lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`x`) (or perhaps I should say between #mi(`x`) and #mi(`0`) since #mi(`x`) is negative).
    Instead, the maximum is #mi(`e^0 = 1`), so we can take #mi(`M = 1`), and then the same argument will succeed.

    The remainder
    #mitex(```
    R_n (x) = e^x - \left( 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots + \frac{x^n}{n!} \right)
    ```)
    is bounded by
    #mitex(```
    \lvert R_n(x) \rvert \leq \frac{1}{(n+1)!} \lvert x \rvert^{n+1}
    ```)
    because #mi(`M = 1`) is greater than or equal to #mi(`\lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`x`) and #mi(`0`).
    By the ratio test, we have
    #mitex(```
    \lim_{n \to \infty} \left\lvert \frac{\lvert x \rvert^{n+2}}{(n+2)!} \cdot \frac{(n+1)!}{\lvert x \rvert^{n+1}} \right\rvert = \lim_{n \to \infty} \frac{\lvert x \rvert}{n+2} = 0 < 1,
    ```)
    so then
    #mitex(```
    \lim_{n \to \infty} \lvert R_n(x) \rvert \leq \lim_{n \to \infty} \frac{1}{(n+1)!} \lvert x \rvert^{n+1} = 0,
    ```)
    and we conclude that the Taylor series converges to #mi(`e^x`) at #mi(`x`) for all #mi(`x < 0`).

  + Let #mi(`f(x) = \cos x`), then we have
    #mitex(```
    \begin{aligned}
    f(x) &= \cos x, \quad f'(x) &= -\sin x, \quad f''(x) &= -\cos x, \quad f^{(3)}(x) &= \sin x, &&\, \\
    f^{(4)}(x) &= \cos x, \quad f^{(5)}(x) &= -\sin x, \quad f^{(6)}(x) &= -\cos x, \quad f^{(7)}(x) &= \sin x, &&\,\\
    f^{(8)}(x) &= \cos x, \quad f^{(9)}(x) &= -\sin x, \quad f^{(10)}(x) &= -\cos x, \quad f^{(11)}(x) &= \sin x, &&\cdots
    \end{aligned}
    ```)
    and thus
    #mitex(```
    \begin{aligned}
    f(0) &= 1, \quad f'(0) &= 0, \quad f''(0) &= -1, \quad f^{(3)}(0) &= 0, &&\, \\
    f^{(4)}(0) &= 1, \quad f^{(5)}(0) &= 0, \quad f^{(6)}(0) &= -1, \quad f^{(7)}(0) &= 0, &&\,\\
    f^{(8)}(0) &= 1, \quad f^{(9)}(0) &= 0, \quad f^{(10)}(0) &= -1, \quad f^{(11)}(0) &= 0, &&\cdots.
    \end{aligned}
    ```)
    Therefore, the Taylor series of #mi(`\cos x`) is
    #mitex(```
    1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \frac{x^6}{6!} + \frac{x^8}{8!} - \cdots = \sum_{n=0}^\infty \frac{(-1)^n x^{2n}}{(2n)!}.
    ```)

    The #mi(`n`)-th remainder at #mi(`x`) is bounded by
    #mitex(```
    \lvert R_n(x) \rvert \leq \frac{1}{(n+1)!} \lvert x \rvert^{n+1}
    ```)
    because #mi(`M = 1`) is greater than or equal to #mi(`\lvert f^{(n+1)}(c) \rvert`) for all #mi(`c`) between #mi(`0`) and #mi(`x`) (note that #mi(`\lvert f^{(n+1)}(c) \rvert`) is either #mi(`\lvert \cos c \rvert`) or #mi(`\lvert \sin c \rvert`), both of which are always less than or equal to #mi(`1`)).
    // By the ratio test, we have
    // #mitex(```
    // \lim_{n \to \infty} \left\lvert \frac{\lvert x \rvert^{n+2}}{(n+2)!} \cdot \frac{(n+1)!}{\lvert x \rvert^{n+1}} \right\rvert = \lim_{n \to \infty} \frac{\lvert x \rvert}{n+2} = 0 < 1,
    // ```)
    // so then
    Therefore, we have
    #mitex(```
    \lim_{n \to \infty} \lvert R_n(x) \rvert \leq \lim_{n \to \infty} \frac{1}{(n+1)!} \lvert x \rvert^{n+1} = 0,
    ```)
    and we can conclude that the Taylor series converges to #mi(`\cos x`) for all #mi(`x`).
]

