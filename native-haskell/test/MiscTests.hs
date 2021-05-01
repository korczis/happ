module MiscTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit(assertEqual, testCase)

import Misc(isAllDigits, replaceAt, swapElems)

tests = testGroup
    "Misc tests"
    [
        isAllDigitsTests,
        replaceAtTest,
        swapElementsTest
    ]


isAllDigitsTests = testGroup
    "Is all digits"
    [
        isAllDigitsTrueTest,
        isAllDigitsFalseTest
    ]

isAllDigitsTrueTest = testCase "String containing only digits" $ do
    assertEqual "" True (isAllDigits "1836459372529")

isAllDigitsFalseTest = testCase "String containing not only digits" $ do
    assertEqual "" False (isAllDigits "18364abc72529")

replaceAtTest =
  testCase "Replace element in list" $ do
    assertEqual "" [1,2,1] (replaceAt 1 2 [1, 1, 1])

swapElementsTest =
  testCase "Swap elements in list" $ do
    assertEqual "" [3, 2, 1, 4, 5] (swapElems (0, 2) [1..5])