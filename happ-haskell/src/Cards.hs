module Cards(
    Card(),
    CardDeck,
    -- CardDeck(),
    CardSuit(..),
    CardValue(..),
    makeCard,
    makeDeck,
    takeCard
) where

data CardSuit = Club
                | Diamond
                | Heart
                | Spade
                deriving (Read, Show, Enum, Eq, Ord)

--instance Show CardSuit where
--    show Club = "♣"
--    show Diamond = "♦"
--    show Heart = "♥"
--    show Spade = "♠"

data CardValue = Two
                 | Three
                 | Four
                 | Five
                 | Six
                 | Seven
                 | Eight
                 | Nine
                 | Ten
                 | Jack
                 | Queen
                 | King
                 | Ace
                 deriving (Read, Show, Enum, Eq, Ord)

type Card = (CardSuit, CardValue)
type CardDeck = [Card]

cardSuits :: [CardSuit]
cardSuits = [Club ..]

cardValues :: [CardValue]
cardValues = [Two ..]

makeCard :: CardSuit -> CardValue -> Card
makeCard s v = (s, v)

makeDeck :: CardDeck
makeDeck = do
    suit <- [Club ..]
    value <- [Two ..]
    return (suit, value)

takeCard :: CardDeck -> (Card, CardDeck)
takeCard d = let (x:xs) = d in (x, xs)
