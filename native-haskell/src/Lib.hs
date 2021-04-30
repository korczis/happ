module Lib( greet ) where

import Basic
import Cards (Card, CardSuit, CardValue)
import Math
import Misc

greet :: IO ()
greet = putStrLn "Hello World!"
