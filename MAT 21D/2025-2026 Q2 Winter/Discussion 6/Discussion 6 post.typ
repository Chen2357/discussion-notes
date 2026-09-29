#import "../Discussion post.typ": *
#show: post

In Discussion 6, we talked about the associated quantities of a curve (velocity, tangent vector, curvature, and normal vector) and line integrals of scalar functions.
The notes also introduces line integrals of vector fields and includes an exercise on it.

#horizontal-line()

I skipped the solution for the second exercise (the one after warm-up) in the interest of time, but it contains an important lesson.
The lesson is that the unit tangent vector (up to sign), curvature, and principal normal vector are all intrinsic to the shape of the curve, so they do not depend on the particular parametrization of the curve.

The velocity and speed, on the other hand, do depend on the particular parametrization of the curve.

#horizontal-line()

In case, I did not emphasize enough during discussion.
The line integral
```
  \int_C f(x, y, z) \, ds
```
is independent of the parametrization of the curve `C`.
It only depends on the shape of the curve `C` and the function `f`.

This is completely analogous to how the double integral
```
  \iint_D f(x, y) \, dA
```
is independent of the particular parametrization of the region `D`.
We can describe it with Cartesian coordinates, polar coordinates, or even arbitrary `(u, v)` coordinates, but they are just different representations of the same double integral, which only depends on `D` and `f`.

#horizontal-line()

The line integrals of vector fields is the beginning of what I think is the fascinating part of the course!
In the very first discussion, I talked a little about the generalized Stokes' theorem and how elegant the notation of differential forms is.
Actually, you can see a little bit of it through the fundamental theorem of calculus for line integrals:
```
  \int_C dU = U(B) - U(A)
```
if `C` is a curve with starting point `A` and ending point `B`, and `U` is a scalar function.
The notation is different from the fundamental theorem in the lecture notes where `dU` is replaced by `\nabla U \cdot d\mathbf{r}`, but they really mean the same thing
```
  \int_C dU = \int_C \frac{\partial U}{\partial x} \, dx + \frac{\partial U}{\partial y} \, dy + \frac{\partial U}{\partial z} \, dz = \int_C \nabla U \cdot d\mathbf{r}
```
if you have the correct interpretation of line integrals with `dx`, `dy`, and `dz` instead of `ds`.
The last exercise in the notes highlight an *incorrect* interpretation of line integrals with `dx` and `dy`.
Originally when writing the exercise, I wanted to discourage you from using this notation because of the potential confusion, so the tone in the notes is negative towards it.
However, I changed my mind, and I hope that the exercise sets you up to appreciate the beautiful way to express the fundamental theorem of calculus for line integrals.