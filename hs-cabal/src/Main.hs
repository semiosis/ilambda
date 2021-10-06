{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
module Main where

import Lib

-- How to add this under the current setup? -- What is haskell-ide using?
import Data.Aeson

main :: IO ()
main = do
  -- putStrLn "Hello world" >> pickUpLine "Haskell" >>= putStrLn
  pickUpLine "Haskell" >>= putStrLn
  d <- pickUpLine "Library"
  putStrLn d