module BasicTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)

import Basic (myDrop, myReverse)

tests = testGroup
    "Basic tests"
    [
        myDropTest,
        myReverseTest
    ]

myDropTest =
  testCase "Drop first n elements from list" $ do
    assertEqual "" [3, 4, 5] (myDrop 2 [1, 2, 3, 4, 5])

myReverseTest =
  testCase "Reverse list" $ do
    assertEqual "" [3, 2, 1] (myReverse [1, 2, 3])