-- A module for UNIX pipe utilities
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module UnixFuncs where

import System.Process

-- This works directly in ghci
-- pickUpLine "Library"
pickUpLine :: String -> IO String
pickUpLine = readProcess "myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

main :: IO ()
main = do
  -- putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d