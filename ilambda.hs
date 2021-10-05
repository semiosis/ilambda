-- A module for UNIX pipe utilities
{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module UnixFuncs where

import System.Process

-- Get the date with the UNIX date command
getDate :: IO String
getDate = readProcess "date" [] ""

-- How do I use getDate in this main function?

main :: IO ()
main = do
  putStrLn "hello world"
  d <- getDate
  putStrLn d