{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson ( decode )
-- import Data.Aeson.Pretty as AesonPretty
import qualified Data.ByteString.Lazy as BLU
import GHC.Generics ()

pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

decodeResultsList :: String -> Maybe [String]
decodeResultsList results = Data.Aeson.decode (BLU.fromString (Prelude.take (Prelude.length results - 1) results :: String)) :: Maybe [String]

getResults :: String -> IO [String]
getResults product = do
  results <- pickUpLine product
  return (decodeResultsList results)

main :: IO ()
main = print getResults "steel"