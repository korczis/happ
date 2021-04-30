module Main (main) where

import Test.Tasty (defaultMain, testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase)

import qualified BasicTests (tests)
import qualified CardsTests (tests)
import qualified MathTests (tests)
import qualified MiscTests (tests)

main = defaultMain tests

tests :: TestTree
tests = testGroup "All tests"
        [
            BasicTests.tests,
            CardsTests.tests,
            MathTests.tests,
            MiscTests.tests
        ]

