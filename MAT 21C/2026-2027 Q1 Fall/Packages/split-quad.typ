#let lerp3d(p1, p2, t) = (
  p1.at(0) + (p2.at(0) - p1.at(0)) * t,
  p1.at(1) + (p2.at(1) - p1.at(1)) * t,
  p1.at(2) + (p2.at(2) - p1.at(2)) * t,
)

// Clips a closed perimeter-ordered polygon against one half-space of y = y-plane.
// keep-above: true keeps points with y >= y-plane; false keeps y <= y-plane.
#let clip-poly-y(pts, y-plane, keep-above: true) = {
  let out = ()
  let n = pts.len()
  let eps = 1e-9

  let is-inside(p) = {
    if keep-above { p.at(1) >= y-plane - eps }
    else { p.at(1) <= y-plane + eps }
  }

  for i in range(n) {
    let curr = pts.at(i)
    let prev = pts.at(calc.rem(i + n - 1, n))

    let curr-in = is-inside(curr)
    let prev-in = is-inside(prev)

    if curr-in {
      if not prev-in {
        // Edge enters the half-space: emit intersection first
        let dy = curr.at(1) - prev.at(1)
        if calc.abs(dy) > eps {
          let t = (y-plane - prev.at(1)) / dy
          out.push(lerp3d(prev, curr, t))
        }
      }
      out.push(curr)
    } else if prev-in {
      // Edge leaves the half-space: emit intersection
      let dy = curr.at(1) - prev.at(1)
      if calc.abs(dy) > eps {
        let t = (y-plane - prev.at(1)) / dy
        out.push(lerp3d(prev, curr, t))
      }
    }
  }

  // Deduplicate consecutive identical points (handles exact vertex hits)
  let clean = ()
  for p in out {
    if clean.len() == 0 {
      clean.push(p)
    } else {
      let last = clean.last()
      let dist = calc.abs(p.at(0) - last.at(0)) + calc.abs(p.at(1) - last.at(1)) + calc.abs(p.at(2) - last.at(2))
      if dist > eps {
        clean.push(p)
      }
    }
  }
  if clean.len() > 1 {
    let first = clean.first()
    let last = clean.last()
    let dist = calc.abs(first.at(0) - last.at(0)) + calc.abs(first.at(1) - last.at(1)) + calc.abs(first.at(2) - last.at(2))
    if dist <= eps {
      let _ = clean.pop()
    }
  }

  return clean
}

// Splits a perimeter-ordered quad (p0, p1, p2, p3) by y = y-plane.
// Returns (intersected: bool, shapes: array of polygons).
// Each polygon has 3 (triangle), 4 (quad), or 5 (pentagon) vertices in original CW winding order.
#let split-quad-y(p0, p1, p2, p3, y-plane) = {
  let quad = (p0, p1, p2, p3)
  let above = clip-poly-y(quad, y-plane, keep-above: true)
  let below = clip-poly-y(quad, y-plane, keep-above: false)

  // Both sides must have at least 3 vertices (a non-degenerate polygon) to count as a split
  if above.len() >= 3 and below.len() >= 3 {
    return (intersected: true, shapes: (above, below))
  }

  return (intersected: false, shapes: (quad,))
}
