#import "../Discussion post.typ": *
#show: post

More thoughts on long division.

During discussion, I suggested that knowing long division method to find the potential function is sufficient, but there are definitely some cases where doing line integral shines.
For example, consider
```
\mathbf{F}(x, y) = \frac{x \mathbf{i} + y \mathbf{j}}{\sqrt{x^2 + y^2}}.
```
If we were to do long division, we would have to think about what is the antiderivative of `\frac{x}{\sqrt{x^2 + y^2}}`.
It is not that bad: it comes out to be `\sqrt{x^2 + y^2}` and as a bonus, it also gives the correct gradient in the `j` component, so we can end long division early.

But, compare this to doing line integral.
If we parameterize `C(x, y)` by `\mathbf{r}(t) = t x \mathbf{i} + t y   \mathbf{j}`, then we have
```
\begin{align}
\int_C \mathbf{F} \cdot d\mathbf{r} &= \int_0^1 \left( \frac{t x \mathbf{i} + t y \mathbf{j}}{\sqrt{(t x)^2 + (t y)^2}} \right) \cdot (x \mathbf{i} + y \mathbf{j}) \, dt \\
&= \int_0^1 \frac{t (x^2 + y^2)}{t \sqrt{x^2 + y^2}} \, dt \\
&= \int_0^1 \sqrt{x^2 + y^2} \, dt \\
&= \sqrt{x^2 + y^2},
\end{align}
```
which gives the same answer and is pretty straightforward.

#horizontal-line()

Long division applies much more generally.
Whenever we are trying to solve `\mathcal{F} x = y` where `\mathcal{F}` is a linear operator, we can try long division.

For example, when we are trying to factor `(x - 2) p(x) = x^2 + 2x + 7` or trying to solve `\frac{d}{dx} f(x) = x^2 e^x` (find the antiderivative of `x^2 e^x`), we can use long division as shown in the images below.