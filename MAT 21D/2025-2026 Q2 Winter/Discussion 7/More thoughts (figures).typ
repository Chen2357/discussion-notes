#set page(width: auto, height: auto, margin: 0in)

#table(
  columns: 4,
  stroke: none,
  [], [], $x$, $+5$,
  table.hline(start: 1),
  $(x-2)$, table.vline(start: 1, end: 2), $x^2$, $+3x$, $-10$,
  [], $x^2$, $-2x$, [],
  table.hline(start: 1),
  [], [], $5x$, $-10$,
  [], [], $5x$, $- 10$,
  table.hline(start: 1),
  [], [], [], $0$
)

#pagebreak()

#table(
  columns: 4,
  stroke: none,
  [], $x^2 e^x$, $-2x e^x$, $+2e^x$,
  table.hline(start: 1),
  $d/(d x)$, table.vline(start: 1, end: 2), $x^2 e^x$, [], [],
  [], $x^2 e^x$, $+2x e^x$, [],
  table.hline(start: 1),
  [], [], $-2 x e^x$, [],
  [], [], $-2 x e^x$, $-2 e^x$,
  table.hline(start: 1),
  [], [], [], $2 e^x$,
  [], [], [], $2 e^x$,
  table.hline(start: 1),
  [], [], [], $0$
)