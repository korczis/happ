module Math.GeometryTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)

import Math.Geometry(areaCircle, areaRectangle, areaSquare)

tests = testGroup
    "Math.Geometry tests"
    [
        areaCircleTest,
        areaRectangleTest,
        areaSquareTest
    ]

areaCircleTest =
  testCase "Calculate area of circle" $ do
    assertEqual "" 12.566370614359172 (areaCircle 2)

areaRectangleTest =
  testCase "Calculate area of rectangle" $ do
    assertEqual "" 35 (areaRectangle 7 5)

areaSquareTest =
  testCase "Calculate area of square" $ do
    assertEqual "" 16 (areaSquare 4)