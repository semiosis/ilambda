{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module Main where

-- How to add this under the current setup? -- What is haskell-ide using?
import Data.Aeson
import System.Process

-- This works directly in ghci
-- pickUpLine "Library"
pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

main :: IO ()
main = do
  -- putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d