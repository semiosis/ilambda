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

-- TOOD Do some truth comparisons
-- Make this return a Bool
-- Even better, make it return True, False or Unknown
factChecker :: String -> IO Bool
factChecker query = do
  s <- readProcess "/home/shane/scripts/myeval" ["pena", "pf-fact-checker/1"] query
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
factQuery = readProcess "/home/shane/scripts/myeval" ["pena", "pf-get-a-factual-result-given-a-question/1"]

penl :: IO String
penl = readProcess "/home/shane/scripts/myeval" ["unbuffer", "penl"] ""

penh :: String -> IO String
penh funName = readProcess "/home/shane/scripts/myeval" ["unbuffer", "penh", funName] ""

-- pena "pf-define-word-for-glossary/1" ["code"]
pena :: String -> [String] -> IO String
pena funName args = readProcess "/home/shane/scripts/myeval" (["unbuffer", "pena", funName] ++ args) ""

penau :: String -> [String] -> IO String
penau funName args = readProcess "/home/shane/scripts/myeval" (["unbuffer", "pena", "-u", funName] ++ args) ""

-- Have an list replicate
listOf :: Integer -> String -> IO String
listOf n thing = pena "pf-list-of/2" [show n, thing]

-- How to modify a function to get it to do it differently?
-- listOf 5 "worst American football teams"
newListOf :: Integer -> String -> IO String
newListOf n = readProcess "/home/shane/scripts/myeval" ["pena", "-u", "pf-list-of/2", show n]

transpile :: String -> String -> String -> IO String
transpile program fromLanguage toLanguage = readProcess "/home/shane/scripts/myeval" ["pena", "pf-transpile/3", fromLanguage, toLanguage] program

pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

-- TODO Ensure I can override various settings but through Haskell
-- Firstly, ensure I can update. I would have to export UPDATE=y to readProcess somehow

askAnyQuestion :: String -> IO String
askAnyQuestion = readProcess "/home/shane/scripts/myeval" ["pena", "pf-ask-any-question-or-yo-be-real/1"]

decodeResultsList :: String -> Maybe [String]
decodeResultsList results = Data.Aeson.decode (BLU.fromString (Prelude.take (Prelude.length results - 1) results :: String)) :: Maybe [String]

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