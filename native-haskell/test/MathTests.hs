module MathTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)

import Math(myGcd, myLcm)

tests =
  testGroup
    "Math tests"
    [
        myGcdTest,
        myLcmTest
    ]

myGcdTest =
  testCase "GCD of 15 and 20 is 5" $ do
    assertEqual "" 5 (myGcd 15 20)

myLcmTest =
  testCase "LCM of 8 and 9 is 72.0" $ do
    assertEqual "" 72.0 (myLcm 8 9)