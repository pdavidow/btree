module CustomFunctions_Tests exposing (..)

import CustomFunctions exposing (lazyUnwrap, digitCount)
import Lazy exposing (lazy)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


customFunctions : Test
customFunctions =
    describe "CustomFunctions module"
         [ describe "CustomFunctions.lazyUnwrap"
            [ test "Nothing" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "5" (CustomFunctions.lazyUnwrap lazyDefault toString Nothing)
            , test "Just" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "3" (CustomFunctions.lazyUnwrap lazyDefault toString (Just 3))
            ]
         , describe "CustomFunctions.digitCount"
            [ test "positive" <|
                \() ->
                    Expect.equal 5 (CustomFunctions.digitCount 12321)
            , test "negative" <|
                \() ->
                    Expect.equal 5 (CustomFunctions.digitCount -12321)
            , test "zero" <|
                \() ->
                    Expect.equal 1 (CustomFunctions.digitCount 0)
            , test "Infinity" <|
                \() ->
                    let
                        infinity = 1000 ^ 1000
                    in
                        Expect.equal infinity (digitCount (1234 ^ 5678))
            ]
        ]

