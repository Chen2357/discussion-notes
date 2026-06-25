#import "../canvas-html.typ": *

#show: canvas-html

In Discussion 9, we talked about surface integrals of scalar and vector fields.
Learning about surface integrals of vector fields get us a step closer to completing the analysis of integrations on 3-dimensional space we started in Discussion 8.

#horizontal-line()

After the discussion, one of you shown me that it is also quite easy to avoid the right hand rule in part 1 of the last question by leveraging the fact that we already calculated
```latex
\mathbf{r}_x \times \mathbf{r}_z = -\mathbf{j}-\mathbf{i}.
```
We need to calculate this anyways, so it is not a big deal that we can leverage this fact.
We can simply plot the vector `-\mathbf{j} - \mathbf{i}` on a point of the surface to see that it is pointing in the direction of the `z`-axis (see image in the notes), and hence we should pick minus sign in the formula for the surface integral of a vector field.

I raised the concern that `\mathbf{r}_u \times \mathbf{r}_v` in general is a function of `u` and `v`, and it would be hard to visualize, but on a second thought, to know how to pick the sign, we just need to pick the sign at one point!
Thus, we can simply pick any point on the surface, calculate `\mathbf{r}_u \times \mathbf{r}_v` at that point and compare it with the orientation specified by the problem to determine the sign.
This is actually quite a robust method!
And I consider it on par if not better than the right hand rule method.