calc_area <- function (F, t)    # Given a Force vector and a time vector, 
{                               # calculates area under the curve using
  a <- F[1: length(F)-1]        # trapezoidal rule, interval by interval
  b <- F[2: length(F)]
  c <- b-a 
  t1 <- t[1:(length(t)-1)]
  t2 <- t[2:length(t)]
  w <- t2-t1
  area <- sum( a*w + (.5*c*w))
  return (area)
}
