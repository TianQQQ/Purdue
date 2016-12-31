function myroots(c)


  r = zeros(1:3)
  println(c[2]^2 - 4 * c[1] * c[3])
  r[1] = (- c[2] + sqrt((c[2]^2 - 4 * c[1] * c[3])) / (2*c[1]))
  r[2] = (- c[2] - sqrt((c[2]^2 - 4 * c[1] * c[3])) / (2*c[1]))

  return r
end
