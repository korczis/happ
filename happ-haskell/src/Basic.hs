module Basic( myDrop, myReverse ) where

myDrop :: Int -> [a] -> [a]
myDrop n xs = if n == 0 || null xs
              then xs
              else myDrop (n - 1) (tail xs)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x : xs) = (myReverse xs) ++ [x]