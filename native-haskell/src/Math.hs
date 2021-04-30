module Math(
        evenness,
        isEven,
        isOdd,
        myGcd,
        myLcm,
        square
       ) where

import Data.Fixed

data Evenness = Odd | Even

instance Show Evenness where
    show Even = "Even"
    show Odd = "Odd"

evenness :: Integral a => a -> Evenness
evenness n = if isEven n
             then Even
             else Odd

isEven :: Integral a => a -> Bool
isEven n = (mod n 2) == 1

isOdd :: Integral a => a -> Bool
isOdd n = not (isEven n)

myGcd :: Float -> Float -> Float
myGcd x y = if y == 0
          then x
          else myGcd y (mod' x y)

myLcm :: Float -> Float -> Float
myLcm x y = (x * y) / (myGcd x y)

square :: Num a => a -> a
square x = x * x