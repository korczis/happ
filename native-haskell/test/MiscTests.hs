module MiscTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit(assertEqual, testCase)

import Misc(replaceAt)

tests =
  testGroup
    "Misc tests"
    [
        replaceAtTest
    ]

replaceAtTest =
  testCase "Replace element at specific index with specified value" $ do
    assertEqual "" [1,2,1] (Misc.replaceAt 1 2 [1, 1, 1])
