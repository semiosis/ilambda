-- A module for UNIX pipe utilities
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module UnixFuncs where

import System.Process

-- Get the date with the UNIX date command
getDate :: IO String
getDate = readProcess "myeval" ["unbuffer", "pena", "-u", "very-witty-pick-up-lines-for-a-topic/1", "haskell"] ""

-- How do I use getDate in this main function?

main :: IO ()
main = do
  putStrLn "Hello world" >> getDate >>= putStrLn
  d <- getDate
  putStrLn d