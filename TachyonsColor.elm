module TachyonsColor exposing (TachyonsColor, tachyonsColorToColor)

import Dict exposing (Dict, fromList)
import Color exposing (Color, black)
import Color.Convert exposing (hexToColor)
import Tachyons.Classes as T exposing (..)


type alias TachyonsColor = String


hexString_black : String
hexString_black = "#000000"


tColorsWithHex : Dict TachyonsColor String
tColorsWithHex =
    -- http://tachyons.io/docs/themes/skins/
    Dict.fromList
        [ ( T.black, hexString_black )
        , ( T.dark_blue, "#00449E" )
        , ( T.dark_green, "#137752" )
        , ( T.dark_red, "#E7040F" )
        , ( T.gray, "#777777" )
        , ( T.light_silver, "#AAAAAA" )
        , ( T.orange, "#FF6300" )
        , ( T.purple, "#5E2CA5" )
        , ( T.white,"#FFFFFF" )
        ]


tachyonsColorToColor : TachyonsColor -> Color
tachyonsColorToColor tColor =
    Dict.get tColor tColorsWithHex
        |> mbHexToColor


mbHexToColor : Maybe String -> Color
mbHexToColor mbHexString =
    Result.withDefault Color.black (mbHexString
        |> Maybe.withDefault hexString_black
        |> hexToColor)

