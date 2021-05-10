module Math.CalculusTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertBool, assertEqual, testCase)

import Math.Calculus(integrate)

tests = testGroup
    "Math.Calculus tests"
    [
        -- integrateTest
    ]

integrateTest =
  testCase "Integrate using numerical method" $ do
    assertEqual "" 10 ((abs $ (10 - (integrate(\x -> 2.0) 0 (5) 0.01))))
