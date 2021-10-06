{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module Main where

import Lib
import Data.Aeson

main :: IO ()
main = do
  -- putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d