#import "@preview/mitex:0.2.6" as mt
#import "@preview/showybox:2.0.4": showybox

#let indigo = rgb(109, 107, 135)
#let red = rgb(199, 56, 52)
#let blue = rgb(15, 101, 160)
#let dark-magenta = rgb(104, 81, 120)

#let mi(it, ..arg) = context {
  if target() == "html" {
    [\\(#it.text\\)]
  } else {
    math.equation(
      alt: "LaTeX: " + it.text,
      mt.mi(it, ..arg),
    )
  }
}

#let mitex(it, ..arg) = context {
  if target() == "html" {
    [\$\$#it.text\$\$]
  } else {
    math.equation(
      alt: "LaTeX: " + it.text,
      block: true,
      mt.mi(it, ..arg),
    )
  }
}

#let incorrect-solution(body) = context {
  if target() == "html" {
    html.elem(
      "div",
      attrs: (
        style: "padding-left: 40px; padding-right: 40px; background: "
          + red.transparentize(80%).to-hex()
          + "; border: .1em dashed "
          + red.to-hex()
          + "; border-radius: 1.5em; padding: .25em 2em; box-sizing: border-box; margin: .5em 0em;",
      ),
      body,
    )
  } else {
    showybox(
      frame: (
        border-color: red,
        body-color: red.lighten(80%),
        thickness: (left: 2pt),
        radius: 0pt,
      ),
      breakable: true,
      body,
    )
  }
}

#let tip(body) = context {
  if target() == "html" {
    html.elem(
      "div",
      attrs: (
        style: "padding-left: 40px; padding-right: 40px; background: "
          + yellow.transparentize(80%).to-hex()
          + "; border: .1em dashed "
          + yellow.to-hex()
          + "; border-radius: 1.5em; padding: .25em 2em; box-sizing: border-box; margin: .5em 0em;",
      ),
      body,
    )
  } else {
    showybox(
      frame: (
        border-color: yellow,
        body-color: yellow.lighten(80%),
        thickness: (left: 2pt),
        radius: 0pt,
      ),
      breakable: true,
      body,
    )
  }
}

#let horizontal-rule(color: black) = context {
  if target() == "html" {
    html.hr(style: "border: 1px solid " + color.to-hex() + ";")
  } else {
    align(center, line(length: 100%, stroke: color))
  }
}

#let exercise(label: [Exercise], body) = context {
  if target() == "html" {
    horizontal-rule(color: dark-magenta)
    html.span(
      style: "color: " + dark-magenta.to-hex() + ";",
      [(#label)],
    )
    body
    horizontal-rule(color: dark-magenta)
  } else {
    showybox(
      frame: (
        border-color: dark-magenta,
        body-color: white.darken(5%),
        thickness: (left: 2pt),
        radius: 0pt,
      ),
      breakable: true,
      [
        #text(dark-magenta)[(#label)]
        #body
      ],
    )
  }
}

#let solution(label: [Solution], body) = context {
  if target() == "html" {
    horizontal-rule(color: red)
    html.span(
      style: "color: " + red.darken(20%).to-hex() + ";",
      [_#label._],
    )
    body
    horizontal-rule(color: red)
  } else {
    text(red)[_#label._]
    body
  }
}

#let theorem(label: none, body) = context {
  if target() == "html" {
    html.elem(
      "div",
      attrs: (
        style: "padding-left: 40px; padding-right: 40px; background: "
          + gray.transparentize(90%).to-hex()
          + "; border: .1em dashed "
          + blue.to-hex()
          + "; border-radius: 1.5em; padding: .25em 2em; box-sizing: border-box; margin: .5em 0em;",
      ),
      {
        if label != none {
          html.span(
            style: "color: " + blue.to-hex() + ";",
            [(#label)],
          )
        }
        body
      },
    )
  } else {
    showybox(
      frame: (
        border-color: blue,
        body-color: white.darken(5%),
        thickness: (left: 2pt),
        radius: 0pt,
      ),
      breakable: true,
      {
        if label != none {
          text(blue)[(#label)]
        }
        body
      },
    )
  }
}

#let table-caption = state("table-caption", none)
#let my-table(caption: none, ..arg) = context {
  table-caption.update(old => caption)
  if target() == "paged" {
    figure(
      table(..arg),
      caption: caption,
    )
  } else {
    table(..arg)
  }
}

#let my-table-style(doc) = {
  show table: it => context {
    if target() == "html" {
      let header-cells = none
      let data-cells = none
      if it.children.at(0).has("children") {
        header-cells = it.children.at(0).children
        data-cells = it.children.slice(1)
      } else {
        data-cells = it.children
      }
      let col-num = calc.max(1, it.columns.len())
      let rows = data-cells.chunks(col-num)
      html.elem(
        "table",
        attrs: (
          "border": "1",
          "style": "border-collapse: collapse; width: 100%;",
        ),
        {
          html.caption(table-caption.get())
          html.tbody({
            if header-cells != none {
              html.tr(header-cells.map(cell => html.th(scope: "col", cell.body)).join())
            }
            rows
              .map(row => html.tr(
                row.map(cell => html.td(cell.body)).join(),
              ))
              .join()
          })
        },
      )
    } else {
      it
    }
  }
  doc
}

#let canvas-html(
  course-id: 1067114,
  image-ids: (:),
  title: "",
  author: "Chen Liang",
  date: datetime.today(),
  heading: true,
  doc,
) = {
  show std.title: it => text(18pt, weight: "bold", it)
  set par(justify: true)

  show link: it => text(teal.darken(40%), it)
  show ref: it => text(teal.darken(40%), it)
  set highlight(fill: yellow)

  show image: it => context {
    if target() == "html" {
      let width = if it.width == auto { 100% } else { it.width }
      if width.ratio != 0% {
        html.elem(
          "img",
          attrs: (
            "src": "/courses/" + course-id + "/files/" + image-ids.at(it.source) + "/preview",
            "alt": if it.alt == none { "" } else { it.alt },
            "width": str(width.ratio / 1%) + "%",
            "style": "background-color: white; display: block; margin-left: auto; margin-right: auto;",
          ),
        )
      } else {
        html.img(
          src: "/courses/" + course-id + "/files/" + image-ids.at(it.source) + "/preview",
          alt: if it.alt == none { "" } else { it.alt },
          width: calc.floor(width.length / 1pt),
          style: "background-color: white; display: block; margin-left: auto; margin-right: auto;",
        )
      }
    } else {
      align(center, it)
    }
  }
  show figure: it => context {
    if target() == "html" {
      if it.kind in ("theorem", "definition", "lemma", "corollary", "proposition") {
        it
      } else {
        html.figure({
          it.body
          if it.caption != none {
            html.figcaption(html.p(style: "text-align: center;", [
              Figure #counter(std.figure).at(it.location()).first():
              #it.caption.body
            ]))
          }
        })
      }
    } else {
      it
    }
  }

  set document(
    title: title,
    author: author,
    date: date,
  )

  set std.heading(numbering: "§I")
  set page(numbering: "1")

  show: my-table-style

  place(top + center, float: true, {
    set align(center)
    std.title()
    author
    linebreak()
    date.display("[month repr:long] [day], [year]")
  })

  doc
}
