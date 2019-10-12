{-# LANGUAGE Rank2Types #-}
module Main where
import           Data.Maybe

newtype Church = Church (forall a. (a -> a) -> a -> a)

instance Show Church where
    show = show . churchToInt

churchToInt :: Church -> Int
churchToInt (Church n) = n (+ 1) 0

intToChurch :: Int -> Maybe Church
intToChurch n | n < 0     = Nothing
              | n == 0    = Just churchZero
              | otherwise = churchIncr <$> intToChurch (n - 1)

churchZero :: Church
churchZero = Church (const id)

churchIncr :: Church -> Church
churchIncr (Church n) = Church (\f x -> f (n f x))

churchAdd :: Church -> Church -> Church
churchAdd (Church n) (Churchopen m) = Church (\f x -> m f (n f x))

churchMult :: Church -> Church -> Church
churchMult (Church n) (Church m) = Church (\f x -> m (n f) x)

main :: IO ()
main = do
    let forty = intToChurch 40
    let nine  = intToChurch 9
    print
        $   churchMult
        <$> (churchAdd <$> forty <*> nine)
        <*> (churchIncr <$> nine)
