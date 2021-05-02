module Math.CoreTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)

import Math.Core(gcd', lcm')

tests = testGroup
    "Math.Core tests"
    [
        gcd'Test,
        lcm'Test
    ]

gcd'Test =
  testCase "Calculate GCD" $ do
    assertEqual "" 5 (gcd' 15 20)

lcm'Test =
  testCase "Calculate LCM" $ do
    assertEqual "" 72.0 (lcm' 8 9)