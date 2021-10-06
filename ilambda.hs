-- A module for UNIX pipe utilities
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module UnixFuncs where

import System.Process

-- Get the date with the UNIX date command
pickUpLine :: String -> IO String
pickUpLine = readProcess "myeval" ["pena", "-u", "very-witty-pick-up-lines-for-a-topic/1"]

main :: IO ()
main = do
  putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d