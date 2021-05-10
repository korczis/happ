module Math.Core(
       gcd',
       lcm'
       ) where

import Data.Fixed

gcd' :: Float -> Float -> Float
gcd' x y = if y == 0
          then x
          else gcd' y (mod' x y)

lcm' :: Float -> Float -> Float
lcm' x y = (x * y) / (gcd' x y)
