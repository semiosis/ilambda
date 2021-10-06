module Lib
    ( pickUpLine
    ) where

import System.Process

-- This works directly in ghci
-- pickUpLine "Library"
pickUpLine :: String -> IO String
pickUpLine = readProcess "/home/shane/scripts/myeval" ["pena", "very-witty-pick-up-lines-for-a-topic/1"]

-- This would be fine for main = someFunc
-- someFunc :: IO ()
-- someFunc = putStrLn "someFunc"
