#import "@preview/mitex:0.2.6" as mit
#import "@preview/percencode:0.1.0": url-encode, percent-encode

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
          src: "/equation_images/" + url-encode(percent-encode("\displaystyle " + it.text, exclude: regex(`[a-zA-Z0-9\-_.!~*'();/?:@=+$,#]`.text))).replace("%25A", "%250A"),
          alt: "LaTeX: " + it.text,
          data-equation-content: it.text,
          data-ignore-a11y-check: ""
        ),
      )
    )
  } else {
    mit.mitex(it, ..arg)
  }
}

#let horizontal-line() = context {
  if target() == "html" {
    html.hr()
  } else {
    align(center, line(length: 100%))
  }
}

#let course-id-state = state("course-id", none)
#let image-ids-state = state("image-ids", (:))

#let set-course-id(id) = course-id-state.update(old => id)
#let add-image-id(name, id) = image-ids-state.update(old => {
  old.insert(name, id)
  return old
})

#let canvas-html(doc) = {
  show raw.where(block: false): it => mi(it)
  show raw.where(block: true): it => mitex(it)

  show image: it => context {
    if target() == "html" {
      html.img(
        src: "/courses/" + course-id-state.get() + "/files/" + image-ids-state.get().at(it.source) + "/preview",
        alt: if it.alt == none { "" } else { it.alt },
        width: 300,
        style: "display: block; margin-left: auto; margin-right: auto;"
      )
    } else {
      show: align.with(center)
      it
    }
  }

  show emph: it => {
    if target() == "html" {
      html.em(it.body)
    } else {
      it
    }
  }

  // show align: it => context {
  //   if target() == "html" {
  //     if it.alignment == center {
  //       html.elem(
  //         "p",
  //         attrs: (style: "text-align: center"),
  //         it.body
  //       )
  //     }
  //   } else {
  //     it
  //   }
  // }

  doc
}