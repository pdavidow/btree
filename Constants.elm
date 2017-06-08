module Constants exposing (..)


nothingString : String
nothingString =
    "N/A"


-- todo
-- Workaround for lack of https://github.com/javcasas/elm-integer
-- see https://elmlang.slack.com/archives/C192T0Q1E/p1496934474043955
maxSafeInt : Int
maxSafeInt = 9007199254740991
