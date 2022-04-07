{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# LANGUAGE OverloadedStrings #-}

import System.Process ( readProcess )
import Data.Aeson ( decode )
import qualified Data.ByteString.Lazy.UTF8 as BLU
import Data.Maybe ( fromJust, fromMaybe )
import Control.Monad ( forM_ )
-- import qualified Test.QuickCheck as QC
-- import Test.HUnit
import Test.HUnit
-- assertBool (Just 12 == Nothing) "HUnit expects the result of the Boolean expression"


-- Remember to use field labels
-- sp +/"data Point = Pt {pointx, pointy :: Float}" "$HOME/glossaries/haskell.txt"


-- I want to create an imaginary list
data Ilist a = Nil | Cons a (Ilist a) deriving Show

append :: Ilist a -> Ilist a -> Ilist a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

instance Functor Ilist where
    -- fmap :: (a -> b) -> Ilist a -> Ilist b
    fmap _ Nil = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative Ilist where
    -- pure :: a -> Ilist a
    pure x = Cons x Nil

    -- (<*>) :: Ilist (a -> b) -> Ilist a -> Ilist b
    Nil <*> _ = Nil
    (Cons g gs) <*> xs = fmap g xs `append` (gs <*> xs)

instance Monad Ilist where
    -- (>>=) :: Ilist a -> (a -> Ilist b) -> Ilist b
    Nil >>= _ = Nil
    (Cons x xs) >>= f = (f x) `append` (xs >>= f)



-- TODO Use the List monad
-- https://www.schoolofhaskell.com/school/starting-with-haskell/basics-of-haskell/13-the-list-monad

-- j:pen-obtain-probabilities

-- TODO Add beam search -- this would increase
-- the coherence and plausibility of the results
-- (minimise the surprisal) with respect to the
-- training data.
-- Could also do an anti-beam search, which
-- selects for the lowest probability tokens to
-- find the most surprising results. This might be useful for generating interesting content.
-- https://towardsdatascience.com/the-power-of-constrained-language-models-cf63b65a035d
-- Come up with a novel function for beam search. The article used numpy, which is not very nice

-- TOOD Do some truth comparisons
-- Make this return a Bool
-- Even better, make it return True, False or Unknown
factChecker :: String -> IO Bool
factChecker query = do
  s <- readProcess "myeval" ["pena", "pf-fact-checker/1"] query
  return (s == "True")

testFacts :: IO ()
testFacts = do
  shouldBeFalse <- factChecker "William Gibson wrote Simulacra & Simulation"
  assertBool "It should be true" (not shouldBeFalse)
  print $ show shouldBeFalse
  shouldBeTrue <- factChecker "Jean Baudrillard wrote Simulacra & Simulation"
  assertBool "It should be true" shouldBeTrue
  print $ show shouldBeTrue

factQuery :: String -> IO String
factQuery = readProcess "myeval" ["pena", "--pool", "pf-get-a-factual-result-given-a-question/1"]

decodeResultsList :: String -> Maybe [String]
decodeResultsList results = Data.Aeson.decode (BLU.fromString (Prelude.take (Prelude.length results - 1) results :: String)) :: Maybe [String]

penl :: IO [String]
penl = lines <$> readProcess "myeval" ["unbuffer", "penl"] ""
-- penl = decodeResultsList <$> Just (readProcess "myeval" ["unbuffer", "penl"] "")

penh :: String -> IO String
penh funName = readProcess "myeval" ["unbuffer", "penh", "--pool", funName] ""

-- pena "pf-define-word-for-glossary/1" ["code"]
pena :: String -> [String] -> IO String
pena funName args = readProcess "myeval" (["unbuffer", "pena", "--pool", funName] ++ args) ""

penau :: String -> [String] -> IO String
penau funName args = readProcess "myeval" (["unbuffer", "pena", "--pool", "-u", funName] ++ args) ""

-- TODO Try the Reader monad to manage state

-- Have an list replicate
listOf :: Integer -> String -> IO String
listOf n thing = pena "pf-list-of/2" [show n, thing]

listOfUpdate :: Integer -> String -> IO String
listOfUpdate n thing = penau "pf-list-of/2" [show n, thing]

-- I need a class to ascribe a listOf call result to some kind of class which updates
testListOf :: IO ()
testListOf = do
   print(2 :: Int)
   print(2 :: Float)

-- How to modify a function to get it to do it differently?
-- listOf 5 "worst American football teams"
newListOf :: Integer -> String -> IO String
newListOf n = readProcess "myeval" ["pena", "--pool", "-u", "pf-list-of/2", show n]

transpile :: String -> String -> String -> IO String
transpile program fromLanguage toLanguage = readProcess "myeval" ["pena", "pf-transpile/3", fromLanguage, toLanguage] program

pickUpLine :: String -> IO String
pickUpLine = readProcess "myeval" ["pena", "--pool", "very-witty-pick-up-lines-for-a-topic/1"]

-- TODO Ensure I can override various settings but through Haskell
-- Firstly, ensure I can update. I would have to export UPDATE=y to readProcess somehow

askAnyQuestion :: String -> IO String
askAnyQuestion = readProcess "myeval" ["pena", "--pool", "pf-ask-any-question-or-yo-be-real/1"]

getResults :: String -> IO (Maybe [String])
getResults product = do
  bks <- listOf 10 "Books by Noam Chomsky"
  jbks <- listOf 10 "Books by Jean Baudrillard"
  l <- listOf 10 "Butterfly species"
  pickuplines <- pickUpLine product
  -- return ((fromMaybe [] (decodeResultsList l)) ++ (fromMaybe [] (decodeResultsList pickuplines)))
  return (decodeResultsList pickuplines)

main :: IO ()
main = do
  output <- getResults "Weather"
  print $ unlines $ fromMaybe [] output
