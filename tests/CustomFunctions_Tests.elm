module CustomFunctions_Tests exposing (..)

import CustomFunctions exposing (lazyUnwrap)
import Lazy exposing (lazy)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String


audioNote : Test
audioNote =
    describe "CustomFunctions module"
         [ describe "CustomFunctions.lazyUnwrap"
            [ test "Nothing" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "5" (lazyUnwrap lazyDefault toString Nothing)
            , test "Just" <|
                \() ->
                    let
                        lazyDefault = lazy (\() -> toString 5)
                    in
                        Expect.equal "3" (lazyUnwrap lazyDefault toString (Just 3))
            ]
        ]