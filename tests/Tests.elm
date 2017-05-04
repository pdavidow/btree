module Tests exposing (..)

--###############################################
import BTree exposing (..) --####################
--###############################################

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String

all : Test
all =
    describe "The BTree module"
        [ describe "BTree.insert"
            [ test "insert into empty tree" <|
                \() ->
                    Expect.equal (Node 1 Empty Empty) (insert 1 Empty)
            ]
        ]