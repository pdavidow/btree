module TachyonsColor_Tests exposing (..)

import TachyonsColor exposing (tachyonsColorToColor)

import Tachyons.Classes as T exposing (..)
import Color.Convert exposing (colorToHex)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


tachyonsColor : Test
tachyonsColor =
    describe "TachyonsColor module"
        [ describe "TachyonsColor.tachyonsColorToColor"
            [ test "found" <|
                \() ->
                    let
                        result =
                            T.purple
                                |> TachyonsColor.tachyonsColorToColor
                                |> Color.Convert.colorToHex
                                |> String.toUpper
                    in
                        Expect.equal "#5E2CA5" result
            , test "not found" <|
                \() ->
                    let
                        result =
                            T.pink
                                |> TachyonsColor.tachyonsColorToColor
                                |> Color.Convert.colorToHex
                                |> String.toUpper
                    in
                        Expect.equal "#000000" result                ]
            ]