#set page(width: auto, height: auto, margin: 0.5pt)
#show: doc => context {
  place(hide(doc))
  query(<cetz>).map(x => x.value).intersperse(pagebreak(weak: true)).join()
}

#include "Discussion 1 canvas.typ"