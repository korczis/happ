module Math.Calculus(
        integrate
       ) where

integrate :: (Enum a, Floating a) => (a -> a) -> a -> a -> a -> a
integrate f from to step = sum $ map calc points where
    calc = (\x -> f(x + step / 2) * step)
    points = [from, from + step .. to - step]