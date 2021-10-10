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
main = putStrLn "hello world"

-- main :: IO ()
-- main = do
--   linesJson <- pickUpLine "Haskell"
--   -- decode linesJson using getResults


-- main :: IO ()
-- main = do
--   putStrLn ((fromJust (getResults "Weather")) <> "\\n\\n\\n" <> (fromJust (getResults "Sunshine")))

-- main = do
--   linesJson <- pickUpLine "Haskell"
--   lines <- decodeResultsList linesJson
--   return $ map (Just . fromJust) lines

--   -- -- print the Maybe [String], lines:
--   -- mapM_ putStrLn (Just lines)