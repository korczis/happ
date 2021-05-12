module Main (main) where

import Test.Tasty (defaultMain, testGroup, TestTree)
import Test.Tasty.HUnit (assertEqual, testCase)

import qualified BasicTests (tests)
import qualified CardsTests (tests)
import qualified External.AccelerateTests (tests)
import qualified External.RepaTests (tests)
import qualified Math.CalculusTests (tests)
import qualified Math.CoreTests (tests)
import qualified Math.GeometryTests (tests)
import qualified MiscTests (tests)

main = defaultMain tests

tests :: TestTree
tests = testGroup
    "All tests"
    [
        BasicTests.tests,
        CardsTests.tests,
        testsExternal,
        testsMath,
        MiscTests.tests
    ]

testsExternal :: TestTree
testsExternal = testGroup
    "External tests"
    [
        External.AccelerateTests.tests,
        External.RepaTests.tests
    ]

testsMath :: TestTree
testsMath = testGroup
    "Math tests"
    [
        Math.CalculusTests.tests,
        Math.CoreTests.tests,
        Math.GeometryTests.tests
    ]