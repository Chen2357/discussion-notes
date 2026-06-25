#import "@preview/cetz:0.4.2"
#import "@preview/numty:0.1.0" as nt

/// Calculate lighting intensity using Lambertian shading.
#let calculate-lighting(
  light-direction: (0, -1, 1),
  ambient-light: 0.2,
  diffuse-strength: 0.8,
  normal,
) = {
  let norm-light = nt.normalize(light-direction)
  let norm-normal = nt.normalize(normal)

  // Lambertian (diffuse) shading.
  let diffuse = calc.max(0, nt.dot(norm-normal, norm-light))

  // Combine ambient and diffuse lighting.
  let intensity = ambient-light + diffuse-strength * diffuse
  return calc.min(1, intensity) // Clamp to [0, 1].
}

/// Interpolate between two colors based on intensity
#let shade-color(color, intensity) = {
  // Convert intensity to RGB scaling.
  // Minimum brightness to avoid pure black.
  let scale = calc.max(0.1, intensity)

  // For built-in colors, create a lighter/darker version
  if type(color) == std.color {
    return color.lighten(100% * (intensity - 0.5))
  }

  // For custom colors, you might need different handling
  return color
}

#let get-direction(x, y, z) = {
  let transformation-z = (
    (nt.cos(z), nt.sin(z), 0),
    (-nt.sin(z), nt.cos(z), 0),
    (0, 0, 1),
  )
  let transformation-y = (
    (nt.cos(y), 0, nt.sin(y)),
    (0, 1, 0),
    (-nt.sin(y), 0, nt.cos(y)),
  )
  let transformation-x = (
    (1, 0, 0),
    (0, nt.cos(x), nt.sin(x)),
    (0, -nt.sin(x), nt.cos(x)),
  )
  let transformation = nt.matmul(
    nt.matmul(
      transformation-z,
      transformation-y,
    ),
    transformation-x,
  )
  return nt.matmul(transformation, nt.c(0, 0, 1)).map(v => v.at(0))
}

#let spherical-param(r, theta, phi) = (
  r * nt.sin(phi) * nt.cos(theta),
  r * nt.sin(phi) * nt.sin(theta),
  r * nt.cos(phi),
)

#let e-r(r, theta, phi) = (
  nt.sin(phi) * nt.cos(theta),
  nt.sin(phi) * nt.sin(theta),
  nt.cos(phi),
)

#let r-differential(r, theta, phi) = e-r(r, theta, phi)

#let e-theta(r, theta, phi) = (
  -r * nt.sin(phi) * nt.sin(theta),
  r * nt.sin(phi) * nt.cos(theta),
  0,
)

#let theta-differential(r, theta, phi) = nt.mult(1 / nt.pow(r * nt.sin(phi), 2), e-theta(r, theta, phi))

#let e-phi(r, theta, phi) = (
  r * nt.cos(phi) * nt.cos(theta),
  r * nt.cos(phi) * nt.sin(theta),
  -r * nt.sin(phi),
)

#let phi-differential(r, theta, phi) = nt.mult(1 / nt.pow(r, 2), e-phi(r, theta, phi))

#let cross(v, w) = (
  v.at(1) * w.at(2) - v.at(2) * w.at(1),
  v.at(2) * w.at(0) - v.at(0) * w.at(2),
  v.at(0) * w.at(1) - v.at(1) * w.at(0),
)