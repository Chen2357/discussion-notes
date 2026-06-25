#import "@preview/mitex:0.2.6" as mit
#import "@preview/percencode:0.1.0": url-encode

#let mi(it, ..arg) = context {
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
  if target() == "html" {
    html.hr()
  } else {
    align(center, line(length: 100%))
  }
}

#let post(doc, preview: true) = {
  show raw.where(block: false): it => mi(it)
  show raw.where(block: true): it => mitex(it)

  doc
}