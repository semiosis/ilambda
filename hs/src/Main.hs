{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Process ( readProcess )
import Data.Aeson ( decode )
import qualified Data.ByteString.Lazy.UTF8 as BLU
import Data.Maybe ( fromJust, fromMaybe )

pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

decodeResultsList :: String -> Maybe [String]
decodeResultsList results = Data.Aeson.decode (BLU.fromString (Prelude.take (Prelude.length results - 1) results :: String)) :: Maybe [String]

getResults :: String -> IO (Maybe [String])
getResults product = do
  results <- pickUpLine product
  return (decodeResultsList results)

main :: IO ()
main = do
    result <- getResults "Weather"
    print $ unlines $ fromMaybe [] result