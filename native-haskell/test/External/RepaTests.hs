module External.RepaTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit(assertEqual, testCase)

import Data.Array.Repa as Repa

tests = testGroup
    "Repa Tests"
    [
        createRepaArray1DTest,
        createRepaArray2DTest,
        createRepaUsingFunctionTest,
        indexArrayTest,
        useMapOnArray1DTest
    ]

createRepaArray1DTest = testCase "Create Repa Array 1D" $ do
    let array = [1..10]
    let arrayRepa = fromListUnboxed(Z :. 10) array :: Array U DIM1 Int
    assertEqual "" array (toList arrayRepa)

createRepaArray2DTest = testCase "Create Repa Array 2D" $ do
    let array = [1..9]
    let arrayRepa = fromListUnboxed(Z :. 3 :. 3) array :: Array U DIM2 Int
    assertEqual "" array (toList arrayRepa)

createRepaUsingFunctionTest = testCase "Create Repa using function" $ do
    let array = [0..9]
    let repaArray  = fromFunction (Z :. 10) (\(Z :. i) -> i :: Int)
    assertEqual "" array (toList repaArray)

indexArrayTest = testCase "Use index to access array element" $ do
    let array = [0..10]
    let repaArray  = fromFunction (Z :. 10) (\(Z :. i) -> i :: Int)
    assertEqual "" 5 (repaArray ! (Z :. 5))

useMapOnArray1DTest = testCase "Use map on Array 1D" $ do
    let arrayIn = [1..10]
    let arrayOut = [2..11]
    let arrayRepaIn = fromListUnboxed(Z :. 10) arrayIn :: Array U DIM1 Int
    let arrayRepaOut = computeS(Repa.map (+1) arrayRepaIn) :: Array U DIM1 Int
    assertEqual "" arrayOut (toList arrayRepaOut)