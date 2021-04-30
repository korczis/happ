module CardsTests (
    tests
) where

import Test.Tasty (testGroup)
import Test.Tasty.HUnit (assertEqual, testCase)

import Cards (Card, CardSuit(..), CardValue(..), makeCard, makeDeck)

tests =
  testGroup
    "Cards tests"
    [
        makeCardTest
    ]

makeCardTest =
  testCase "Makes card from CardSuit and CardValue" $ do
    assertEqual "" (Spade, Ace) (makeCard Spade Ace)

makeDeckTest =
  testCase "Card deck contains 52 cards" $ do
    assertEqual "" 52 (length makeDeck)