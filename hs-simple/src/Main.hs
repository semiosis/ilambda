{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

-- How to add this under the current setup? -- What is haskell-ide using?
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import System.Process ( readProcess )

import Data.Text
import GHC.Generics

-- This works directly in ghci
-- pickUpLine "Library"
pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

-- -- Read list of strings using Aeson
-- aesonReadListOfStrings :: String -> Maybe [String]
-- aesonReadListOfStrings = decode

-- Converting strings
-- https://stackoverflow.com/questions/3232074/what-is-the-best-way-to-convert-string-to-bytestring

main :: IO ()
main = do
  -- >> discards the return value of the previous function, so you may use after putStrLn.
  -- >> is the hidden behaviour of newlines in do notation
  pickUpLine "Haskell" >>= putStrLn >> pickUpLine "Haskell" >>= putStrLn >> putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= pickUpLine "Haskell" >>= putStrLn
  putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d