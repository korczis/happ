module Misc(
    isAllDigits,
    knuthShuffle,
    makePredictableRands,
    makeRands,
    myRandoms,
    replaceAt,
    swapElems,

) where

import System.Random
import Data.List
import Control.Monad

isAllDigits :: String -> Bool
isAllDigits val = all (== True)
  $ map (\x -> elem x ['1', '2', '3', '4', '5', '6', '7', '8', '9']) val

knuthShuffle :: [a] -> IO [a]
knuthShuffle xs =
  liftM (foldr swapElems xs. zip [1..]) (makeRands (length xs))

--makePredictableRands :: Int -> StdGen -> ([Int], StdGen)
makePredictableRands c sg m = if c == 0
                          then []
                          else let (r, sgNew) = next sg in
                            [mod r m] ++ (makePredictableRands (c-1) sgNew m)

makeRands :: Int -> IO [Int]
makeRands = mapM (randomRIO.(,)0 ). enumFromTo 0. pred

--myRandoms :: [Word]
myRandoms = let rolls :: RandomGen g => Int -> g -> [Word]
                rolls n = take n . unfoldr (Just . randomR (1, 6))
                pureGen = mkStdGen 137
            in
                rolls 10 pureGen :: [Word]

replaceAt :: Int -> a -> [a] -> [a]
replaceAt i c l = let (a,b) = splitAt i l in a++c:(drop 1 b)

swapElems :: (Int, Int) -> [a] -> [a]
swapElems (i,j) xs | i==j = xs
                   | otherwise = replaceAt j (xs!!i) $ replaceAt i (xs!!j) xs



