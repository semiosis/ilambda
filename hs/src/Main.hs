{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# LANGUAGE OverloadedStrings #-}

import System.Process ( readProcess )
import Data.Aeson ( decode )
import qualified Data.ByteString.Lazy.UTF8 as BLU
import Data.Maybe ( fromJust, fromMaybe )
import Control.Monad ( forM_ )

-- Have an list replicate
listOf :: Integer -> String -> IO String
listOf n = readProcess "/home/shane/scripts/myeval" ["pena", "pf-list-of/2", show n]

transpile :: String -> String -> String -> IO String
transpile program fromLanguage toLanguage = readProcess "/home/shane/scripts/myeval" ["pena", "pf-transpile/3", fromLanguage, toLanguage] program

pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

decodeResultsList :: String -> Maybe [String]
decodeResultsList results = Data.Aeson.decode (BLU.fromString (Prelude.take (Prelude.length results - 1) results :: String)) :: Maybe [String]

getResults :: String -> IO (Maybe [String])
getResults product = do
  bks <- listOf 10 "Books by Noam Chomsky"
  l <- listOf 10 "Butterfly species"
  pickuplines <- pickUpLine product
  -- return ((fromMaybe [] (decodeResultsList l)) ++ (fromMaybe [] (decodeResultsList pickuplines)))
  return (decodeResultsList pickuplines)

main :: IO ()
main = do
  output <- getResults "Weather"
  print $ unlines $ fromMaybe [] output