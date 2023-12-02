module Main where

import Prelude

import Data.Array (length, filter, head, last)
import Data.Char (toCharCode)
import Data.Foldable (sum)
import Data.Int (fromString, toNumber)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String.CodeUnits (toChar, toCharArray, fromCharArray)
import Data.String.Common (replaceAll)
import Data.String.Utils (lines)
import Data.Number.Format (toString)
import Data.String.Pattern (Pattern(..), Replacement(..))

import Effect (Effect)
import Effect.Console (log)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

isNum :: Char -> Boolean
isNum c = toCharCode c > 47 && toCharCode c < 58

pickNumber :: String -> Int
pickNumber s = do
    let
        nums = filter isNum ( toCharArray s )
    fromMaybe 0 $ fromString $ fromCharArray [ fromMaybe '0' $ head nums, fromMaybe '0' $ last nums]

one :: String -> Int
one path = sum $ map pickNumber $ lines path

two :: String -> Int
two s = one $ replaceAll (Pattern "one") (Replacement "one1one") $
    replaceAll (Pattern "two") (Replacement "two2two") $
    replaceAll (Pattern "three") (Replacement "three3three") $
    replaceAll (Pattern "four") (Replacement "four4four") $
    replaceAll (Pattern "five") (Replacement "five5five") $
    replaceAll (Pattern "six") (Replacement "six6six") $
    replaceAll (Pattern "seven") (Replacement "seven7seven") $
    replaceAll (Pattern "eight") (Replacement "eight8eight") $
    replaceAll (Pattern "nine") (Replacement "nine9nine") $
    s

main :: Effect Unit
main = do
    input <- readTextFile UTF8 "../input.txt"

    log $ toString $ toNumber $ one input
    log $ toString $ toNumber $ two input


