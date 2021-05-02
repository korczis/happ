module Math.Playground (
       generatePoint2D
       ) where

import System.Random
import Data.List

generatePoint2D rMin rMax = let rolls :: RandomGen g => Int -> g -> [Word]
                                rolls n = take n . unfoldr (Just . randomR (rMin, rMax))
                                generate n = rolls n
                                pureGen = mkStdGen 137
                            in
                                generate 10 pureGen :: [Word]