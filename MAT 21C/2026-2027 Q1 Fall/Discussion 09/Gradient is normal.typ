#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 4.0pt, fill: white.transparentize(100%))

/// Clips a circle against an axis-aligned rectangle.
///
/// - circle-center (array): (cx, cy) coordinates of the circle center
/// - radius (float): Radius of the circle
/// - rect-center (array): (rx, ry) coordinates of the rectangle center
/// - half-w (float): Horizontal radius (half-width) of the rectangle
/// - half-h (float): Vertical radius (half-height) of the rectangle
/// -> array: Array of dictionaries `(center: (cx, cy), start: angle, stop: angle)`
#let clip-circle-rect(circle-center, radius, rect-center, half-w, half-h) = {
  let (cx, cy) = circle-center
  let (rx, ry) = rect-center
  let r = radius

  if r <= 0 or half-w <= 0 or half-h <= 0 {
    return ()
  }

  // Rectangle bounds
  let x-min = rx - half-w
  let x-max = rx + half-w
  let y-min = ry - half-h
  let y-max = ry + half-h

  // Helper to check if a point (x, y) is inside or on the rectangle
  let in-rect(x, y) = {
    let eps = 1e-9
    x >= x-min - eps and x <= x-max + eps and y >= y-min - eps and y <= y-max + eps
  }

  // Normalize any angle into [0deg, 360deg)
  let norm-angle(a) = {
    let deg = calc.rem(a / 1deg, 360.0)
    if deg < 0 { deg += 360.0 }
    deg * 1deg
  }

  // Collect candidate split angles (in degrees as floats for easy sorting)
  let angles = (0.0, 360.0)

  // Intersections with vertical lines: x = x-min and x = x-max
  for x-bound in (x-min, x-max) {
    let dx = x-bound - cx
    if calc.abs(dx) < r {
      let theta = calc.acos(dx / r) / 1deg
      angles.push(theta)
      angles.push(360.0 - theta)
    }
  }

  // Intersections with horizontal lines: y = y-min and y = y-max
  for y-bound in (y-min, y-max) {
    let dy = y-bound - cy
    if calc.abs(dy) < r {
      let theta = calc.asin(dy / r) / 1deg
      angles.push(norm-angle(theta * 1deg) / 1deg)
      angles.push(norm-angle((180.0 - theta) * 1deg) / 1deg)
    }
  }

  // Sort angles ascending and deduplicate close values
  let sorted = angles.sorted()
  let unique = ()
  for a in sorted {
    if unique.len() == 0 or calc.abs(a - unique.last()) > 1e-7 {
      unique.push(a)
    }
  }

  // Test the midpoint of each angular segment
  let raw-arcs = ()
  for i in range(unique.len() - 1) {
    let a1 = unique.at(i)
    let a2 = unique.at(i + 1)
    let mid = ((a1 + a2) / 2.0) * 1deg

    let mx = cx + r * calc.cos(mid)
    let my = cy + r * calc.sin(mid)

    if in-rect(mx, my) {
      raw-arcs.push((start: a1, stop: a2))
    }
  }

  // Merge adjacent segments (e.g. across the 0deg / 360deg seam)
  let merged = ()
  for seg in raw-arcs {
    if merged.len() > 0 and calc.abs(merged.last().stop - seg.start) < 1e-7 {
      merged.last().stop = seg.stop
    } else {
      merged.push(seg)
    }
  }

  // If the first arc starts at 0deg and the last ends at 360deg (and isn't the full circle), wrap them together
  if merged.len() > 1 and calc.abs(merged.first().start - 0.0) < 1e-7 and calc.abs(merged.last().stop - 360.0) < 1e-7 {
    let first = merged.remove(0)
    merged.last().stop = first.stop + 360.0
  }

  // Format output with Typst angles
  merged.map(a => (
    center: circle-center,
    start: a.start * 1deg,
    stop: a.stop * 1deg,
  ))
}

/// Clips a line segment against an axis-aligned rectangle using Liang-Barsky.
///
/// - p0 (array): (x0, y0) start point of the line segment
/// - p1 (array): (x1, y1) end point of the line segment
/// - rect-center (array): (rx, ry) coordinates of the rectangle center
/// - half-w (float): Horizontal radius (half-width) of the rectangle
/// - half-h (float): Vertical radius (half-height) of the rectangle
/// -> dictionary | none: `(start: (x, y), stop: (x, y))` if visible, or `none` if clipped away
#let clip-line-rect(p0, p1, rect-center, half-w, half-h) = {
  if half-w <= 0 or half-h <= 0 {
    return none
  }

  let (x0, y0) = p0
  let (x1, y1) = p1
  let (rx, ry) = rect-center

  let x-min = rx - half-w
  let x-max = rx + half-w
  let y-min = ry - half-h
  let y-max = ry + half-h

  let dx = x1 - x0
  let dy = y1 - y0

  let t0 = 0.0
  let t1 = 1.0

  // (p, q) pairs for left, right, bottom, top boundaries
  let checks = (
    (-dx, x0 - x-min),
    ( dx, x-max - x0),
    (-dy, y0 - y-min),
    ( dy, y-max - y0),
  )

  for (p, q) in checks {
    if calc.abs(p) < 1e-12 {
      // Line is parallel to this boundary; outside if q < 0
      if q < 0 {
        return none
      }
    } else {
      let r = q / p
      if p < 0 {
        // Entering the clipping window
        if r > t1 { return none }
        if r > t0 { t0 = r }
      } else {
        // Exiting the clipping window
        if r < t0 { return none }
        if r < t1 { t1 = r }
      }
    }
  }

  (
    start: (x0 + t0 * dx, y0 + t0 * dy),
    stop:  (x0 + t1 * dx, y0 + t1 * dy),
  )
}

#let draw-arcs(arcs, ..args) = {
  for a in arcs {
    cetz.draw.arc(
      a.center,
      start: a.start,
      stop: a.stop,
      anchor: "origin",
      ..args,
    )
  }
}

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray.darken(20%), mark: (end: "straight"))

  let x-min = -2.8
  let x-max = 2.8
  let y-min = -2.8
  let y-max = 2.8

  let v-max = 2
  let v-count = 4
  let v-step = v-max / v-count
  let v-fine-count = 10
  let v-fine-step = v-step / v-fine-count

  for v in nt.linspace(0, v-max, v-count + 1) {
    circle((0, 0), radius: v, stroke: red + 1pt)
    for j in range(1, v-fine-count + 1) {
      let delta-v = j * v-fine-step
      circle((0, 0), radius: v + delta-v, stroke: red.lighten(75%) + 0.5pt)
    }
  }

  let angle = 30deg
  let r = 2
  let point = nt.mult((nt.cos(angle), nt.sin(angle)), 2)
  circle(point, radius: 3.5pt, fill: red, stroke: none)

  let point-label-end = (1.8, 1.5)
  line((point, 0.1, point-label-end), point-label-end)
  content((), anchor: "south", padding: (bottom: 2pt, left: 2pt))[#set text(14pt); $(x_0, y_0)$]

  let gradient = (nt.cos(angle), nt.sin(angle))

  line(point, nt.add(point, gradient), stroke: blue + 1.5pt, mark: (end: "straight"), name: "gradient")
  content("gradient.mid", anchor: "north-west", padding: (top: 2pt, left: 2pt))[#set text(14pt); $nabla f(x_0, y_0)$]

  let level-curve-label-angle = 110deg
  let level-curve-label-start = nt.mult((nt.cos(level-curve-label-angle), nt.sin(level-curve-label-angle)), 2)
  let level-curve-label-end = (-1, 2.4)
  line(level-curve-label-start, level-curve-label-end)
  content((), anchor: "south")[#set text(14pt); Level curve of $f(x, y)$]

  let box-radius = 0.2
  line(
    nt.add(point, (-box-radius, -box-radius)),
    nt.add(point, (box-radius, -box-radius)),
    nt.add(point, (box-radius, box-radius)),
    nt.add(point, (-box-radius, box-radius)),
    close: true,
  )
  let big-box-radius = 1
  let big-box-center = (2.3, -1.2)

  line(
    nt.add(point, (-box-radius, -box-radius)),
    nt.add(big-box-center, (-big-box-radius, -big-box-radius)),
    stroke: 0.5pt,
  )
  line(
    nt.add(point, (box-radius, -box-radius)),
    nt.add(big-box-center, (big-box-radius, -big-box-radius)),
    stroke: 0.5pt,
  )
  line(
    nt.add(point, (box-radius, box-radius)),
    nt.add(big-box-center, (big-box-radius, big-box-radius)),
    stroke: 0.5pt,
  )
  line(
    nt.add(point, (-box-radius, box-radius)),
    nt.add(big-box-center, (-big-box-radius, big-box-radius)),
    stroke: 0.5pt,
  )

  translate(big-box-center)
  scale(big-box-radius / box-radius)
  translate(nt.mult(point, -1))
  let modified-radius = box-radius + 0.002
  line(
    nt.add(point, (-box-radius, -box-radius)),
    nt.add(point, (box-radius, -box-radius)),
    nt.add(point, (box-radius, box-radius)),
    nt.add(point, (-box-radius, box-radius)),
    close: true,
    fill: white,
    stroke: none
  )
  on-layer(5, {
    line(
      nt.add(point, (-modified-radius, -modified-radius)),
      nt.add(point, (modified-radius, -modified-radius)),
      nt.add(point, (modified-radius, modified-radius)),
      nt.add(point, (-modified-radius, modified-radius)),
      close: true,
      stroke: 2pt
    )
  })

  for v in nt.linspace(0, v-max, v-count + 1) {
    draw-arcs(
      clip-circle-rect((0, 0), v, point, box-radius, box-radius),
      radius: v,
      stroke: red + 3pt,
    )
    for j in range(1, v-fine-count + 1) {
      let delta-v = j * v-fine-step
      draw-arcs(
        clip-circle-rect((0, 0), v + delta-v, point, box-radius, box-radius),
        radius: v + delta-v,
        stroke: red.lighten(50%) + 2.5pt,
      )
    }
  }
  let clipped-gradient = clip-line-rect(point, nt.add(point, gradient), point, box-radius, box-radius)
  line(
    clipped-gradient.start,
    clipped-gradient.stop,
    stroke: blue + 3pt,
  )
})

