#let data = (
  read("Contours.csv").split("\n").slice(0, -1).map(row => row.split(",").map(s => float(s.slice(0, s.len() - 1))))
)

#let labels = (
  (point: (-3.8, -4), height: 40),
  (point: (-2.4, -3.6), height: 80),
  (point: (-0.8, -3.3), height: 120),
  (point: (-0, -2.35), height: 160),
  (point: (0.5, -1.3), height: 200),
  (point: (0.9, -0.2), height: 240),
  (point: (-0.8, 3.08), height: 120),
  (point: (1.2, 2.8), height: 160),
  (point: (-3.4, 3.3), height: 120),
  (point: (-4.5, 4.0), height: 160),
)

#let key-frames-with-time = (
  (8, (-3.3, -3.0)),
  (9, (-2, -3.5)),
  (10, (-1, -3.8)),
  (11, (0, -3.2)),
  (12, (1.4, -1.7)),
  (13, (2.7, -0.15)),
  (13.5, (3.1, 1)),
  (14, (2.8, 1.8)),
  (15, (1.6, 2.4)),
  (16, (0.1, 2.6)),
  (17, (-1, 2)),
  (18, (-1.7, 1.0)),
)

#let key-frames = key-frames-with-time.map(p => p.at(1))

#let lunch-index = 4

#let f(x, y) = {
  let x_r = x - 1.0
  let y_r = y - 0.5
  let hill_right = 2.0 * calc.exp(-(0.12 * x_r * x_r - 0.08 * x_r * y_r + 0.18 * y_r * y_r))

  let x_l = x + 1.5
  let y_l = y + 1.0
  let hill_left = 1.2 * calc.exp(-(0.15 * x_l * x_l + 0.06 * x_l * y_l + 0.10 * y_l * y_l))

  let x_phantom = x + 6.0
  let y_phantom = y - 6.0
  let hill_phantom = 3.0 * calc.exp(-(0.10 * x_phantom * x_phantom + 0.10 * y_phantom * y_phantom))

  let background_slope = 0.15 * x + 0.05 * y

  return hill_right + hill_left + hill_phantom + background_slope
}

#let key-frame-values = key-frames.map(p => f(..p) * 68 + 35)
