#import "@preview/mitex:0.2.6" as mit
#import "@preview/percencode:0.1.0": url-encode

#let html-output = false

#let mi(it, ..arg) = context {
  if html-output == false {
    mit.mi(it, ..arg)
    return
  }
  if target() == "html" {
    box(html.elem(
      "img",
        attrs: (
        class: "equation_image",
        title: it.text,
        src: "/equation_images/" + url-encode(it.text),
        alt: "LaTeX: " + it.text,
        data-equation-content: it.text,
      ),
    ))
  } else {
    mit.mi(it, ..arg)
  }
}

#let mitex(it, ..arg) = context {
  if html-output == false {
    mit.mitex(it, ..arg)
    return
  }
  if target() == "html" {
    html.elem(
      "p",
      attrs: (style: "text-align: center"),
      html.elem(
        "img",
          attrs: (
          class: "equation_image",
          title: it.text,
          src: "/equation_images/" + url-encode(it.text),
          alt: "LaTeX: " + it.text,
          data-equation-content: it.text,
        ),
      )
    )
  } else {
    mit.mitex(it, ..arg)
  }
}

#show raw.where(block: false): it => mi(it)
#show raw.where(block: true): it => mitex(it)

#let horizontal-line() = context {
  if html-output == false {
    align(center, line(length: 100%))
    return
  }
  if target() == "html" {
    html.hr()
  } else {
    align(center, line(length: 100%))
  }
}

In Discussion 5, we talked about substitutions in double integrals.
The notes also contain an example on substitution in triple integrals.

There are two situations that we need to deal with when performing a substitution in a `dx \, dy` integral.
The first situation being that we are given `x` and `y` as functions of `u` and `v`, and the second situation being that we are given `u` and `v` as functions of `x` and `y`.
Let me explain the two situations separately and explain why it is worth knowing both of them.

#horizontal-line()

In the first situation, we are given `x = g(u, v)` and `y = h(u, v)`, and we need to compute the Jacobian determinant `\frac{\partial (x, y)}{\partial (u, v)}` which will be a function `u` and `v`.
Then we can rewrite the integral
```
  \iint_R f(x, y) \, dx \, dy
```
by changing
- `R` to `G` provided that `R` is equivalent to `G` under the substitution,
- `f(x, y)` to `F(u, v)` provided that `f(x, y) = F(u, v)` when `x = g(u, v)` and `y = h(u, v)`, and
- `dx \, dy` to `\frac{\partial (x, y)}{\partial (u, v)} du \, dv`.
Thus, we have
```
  \iint_R f(x, y) \, dx \, dy = \iint_G F(u, v) \left|\frac{\partial (x, y)}{\partial (u, v)}\right| du \, dv.
```

#horizontal-line()

In the second situation, we are given `u = p(x, y)` and `v = q(x, y)`, and we need to compute the Jacobian determinant `\frac{\partial (u, v)}{\partial (x, y)}` which will be a function in `x` and `y`.
Then we can rewrite the integral
```
  \iint_R f(x, y) \left| \frac{\partial (u, v)}{\partial (x, y)} \right| \, dx \, dy
```
by changing
- `R` to `G` provided that `R` is equivalent to `G` under the substitution,
- `f(x, y)` to `F(u, v)` provided that `f(x, y) = F(u, v)` when `u = p(x, y)` and `v = q(x, y)`, and
- `\frac{\partial (u, v)}{\partial (x, y)} dx \, dy` to `du \, dv`.
Thus, we have
```
  \iint_R f(x, y) \left| \frac{\partial (u, v)}{\partial (x, y)} \right| \, dx \, dy = \iint_G F(u, v) du \, dv.
```

This second situation is much more similar to `u`-substitution in single-variable integrals.
For example, when we are evaluating `\int_0^1 2x e^{x^2} \, dx`, we can let `u = x^2` and then `du = 2x\, dx`, so the integral becomes `\int_0^1 e^u du`.
We have to spot `2x\, dx` in the original integral and change it to `du`.
Similarly, in the two-variable case, we have to spot `\left| \frac{\partial (u, v)}{\partial (x, y)} \right| dx \, dy` in the original integral and change it to `du \, dv`.

#horizontal-line()

I have seen some of you trying to force one method such as in the second exercise in the notes where we are given `u = x y` and `v = \frac{y}{x}`, we still try to revert to the first situation by solving for `x` and `y` in terms of `u` and `v`.
It will work, and you should try it!
You will see that `x = \sqrt{\frac{u}{v}}` and `y = \sqrt{uv}` are not very nice functions to differentiate.

I also have seen some of you trying to apply
```
  \frac{\partial (x, y)}{\partial (u, v)} = \left(\frac{\partial (u, v)}{\partial (x, y)}\right)^{-1}
```
which is another true fact (see exercise 15.8.27), it is just that we have not learned it (and we will not learn it in this class).
The difficulty of this approach lies in that `\frac{\partial (u, v)}{\partial (x, y)}` is a function in `x` and `y`, and we will need to change it to a function in `u` and `v`.

These workarounds can lead to complications.
It is definitely worth knowing both the methods outlined in the notes.