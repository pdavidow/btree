module Generator exposing (generatorDelta, generatorExponent, generateIds, generatorTreeMusicNotes, generatorIntNodes, generatorBigIntNodes, generatorStringNodes, generatorBoolNodes, generatorNodeVarieties, generatorTuplesOfMusicNoteDirection, generatorTuplesOfIntNode_Direction, generatorTuplesOfBigIntNode_Direction, generatorTuplesOfStringNode_Direction, generatorTuplesOfBoolNode_Direction, generatorTuplesOfNodeVariety_Direction)

import Maybe.Extra exposing (unwrap)
import List.Extra exposing (last)
import Random exposing (int, bool, pair, list, andThen, generate)
import Random.String exposing (rangeLengthString)
import Random.Char exposing (english)
import BigInt exposing (BigInt, fromInt)
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)
import Lazy exposing (lazy)

import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import BTree exposing (Direction(..))
import MusicNotePlayer exposing (MusicNotePlayer(..), on)
import MusicNote exposing (MusicNote(..), MidiNumber(..), minMidiNumber, maxMidiNumber)
import MaybeSafe exposing (toMaybeSafeInt)
import Lib exposing (lazyUnwrap)


minRandomDelta = 1
maxRandomDelta = 100

minRandomExponent = 1
maxRandomExponent = 10

minRandomTreeInt = 1
maxRandomTreeInt = 999

minRandomTreeStringLength = 3
maxRandomTreeStringLength = 10

minRandomListLength = 3
maxRandomListLength = 12


generatorDelta : Random.Generator Int
generatorDelta =
    Random.int minRandomDelta maxRandomDelta


generatorExponent : Random.Generator Int
generatorExponent =
    Random.int minRandomExponent maxRandomExponent


generateIds : Int -> Seed -> ( List Uuid, Seed )
generateIds count startSeed =
    let
        generate = \seed -> step uuidGenerator seed

        fn : Maybe a -> ( Uuid, Seed ) -> ( Uuid, Seed )
        fn = \a ( id, seed ) -> generate seed

        tuples =
            List.repeat (count - 1) Nothing
                |> List.scanl fn (generate startSeed)

        ids = List.map Tuple.first tuples

        lazyDefault = Lazy.lazy (\() -> ( Tuple.first (generate startSeed), startSeed ))

        currentSeed =
            tuples
                |> List.Extra.last
                |> lazyUnwrap lazyDefault identity
                |> Tuple.second
    in
        ( ids, currentSeed )


boolToDirection : Bool -> Direction
boolToDirection b =
    case b of
        True -> Right
        False -> Left


generatorNothingNode : Random.Generator NothingNode
generatorNothingNode =
    Random.map (\b -> NothingNodeVal) Random.bool -- whatever


generatorRandomListLength : Random.Generator Int
generatorRandomListLength =
    Random.int minRandomListLength maxRandomListLength


generatorTreeMusicNote : Random.Generator MusicNote
generatorTreeMusicNote =
    let
        (MidiNumber min) = minMidiNumber
        (MidiNumber max) = maxMidiNumber
    in
        Random.map (\i -> MusicNote <| MidiNumber i) <| Random.int min max


generatorTreeMusicNotes : Random.Generator (List MusicNote)
generatorTreeMusicNotes =
    let
        randomMusicNotes : Int -> Random.Generator (List MusicNote)
        randomMusicNotes length =
            Random.list length generatorTreeMusicNote
    in
        Random.andThen randomMusicNotes generatorRandomListLength


generatorMusicNoteNode : Random.Generator MusicNoteNode
generatorMusicNoteNode =
    generatorTreeMusicNote
        |> Random.map (\n -> MusicNoteNodeVal <| MusicNotePlayer.on n)


generatorTreeInt : Random.Generator Int
generatorTreeInt =
    Random.int minRandomTreeInt maxRandomTreeInt


generatorIntNode : Random.Generator IntNode
generatorIntNode =
    generatorTreeInt
        |> Random.map (\i -> IntNodeVal <| toMaybeSafeInt i)


generatorIntNodes : Random.Generator (List IntNode)
generatorIntNodes =
    let
        nodes : Int -> Random.Generator (List IntNode)
        nodes length =
            Random.list length generatorIntNode
    in
        Random.andThen nodes generatorRandomListLength


generatorBigIntNode : Random.Generator BigIntNode
generatorBigIntNode =
    generatorTreeInt
        |> Random.map (\i -> BigIntNodeVal <| BigInt.fromInt i)


generatorBigIntNodes : Random.Generator (List BigIntNode)
generatorBigIntNodes =
    let
        nodes : Int -> Random.Generator (List BigIntNode)
        nodes length =
            Random.list length generatorBigIntNode
    in
        Random.andThen nodes generatorRandomListLength


generatorTreeString : Random.Generator String
generatorTreeString =
    Random.String.rangeLengthString
        minRandomTreeStringLength
        maxRandomTreeStringLength
        Random.Char.english


generatorStringNode : Random.Generator StringNode
generatorStringNode =
    generatorTreeString
        |> Random.map StringNodeVal


generatorStringNodes : Random.Generator (List StringNode)
generatorStringNodes =
    let
        nodes : Int -> Random.Generator (List StringNode)
        nodes length =
            Random.list length generatorStringNode
    in
        Random.andThen nodes generatorRandomListLength


generatorTreeBool : Random.Generator Bool
generatorTreeBool =
    Random.bool


generatorBoolNode : Random.Generator BoolNode
generatorBoolNode =
    generatorTreeBool
        |> Random.map (\b -> BoolNodeVal <| Just b)


generatorBoolNodes : Random.Generator (List BoolNode)
generatorBoolNodes =
    let
        nodes : Int -> Random.Generator (List BoolNode)
        nodes length =
            Random.list length generatorBoolNode
    in
        Random.andThen nodes generatorRandomListLength


generatorNodeVariety : Random.Generator NodeVariety
generatorNodeVariety =
    let
        nodeVarietyOfInterestCount = 5

        generatorOn : Int -> Random.Generator NodeVariety
        generatorOn selector =
            case selector of
                1 ->
                    Random.map IntVariety generatorIntNode

                2 ->
                    Random.map BigIntVariety generatorBigIntNode

                3 ->
                    Random.map StringVariety generatorStringNode

                4 ->
                    Random.map BoolVariety generatorBoolNode

                5 ->
                    Random.map MusicNoteVariety generatorMusicNoteNode

                _ -> -- should never get here
                    Random.map NothingVariety generatorNothingNode
    in
        Random.int 1 nodeVarietyOfInterestCount
            |> andThen generatorOn


generatorNodeVarieties : Random.Generator (List NodeVariety)
generatorNodeVarieties =
    let
        nodes : Int -> Random.Generator (List NodeVariety)
        nodes length =
            Random.list length generatorNodeVariety
    in
        Random.andThen nodes generatorRandomListLength


generatorTuplesOfMusicNoteDirection : Random.Generator (List (MusicNote, Direction))
generatorTuplesOfMusicNoteDirection =
    let
        randomTuplesOfMusicNoteDirection : Int -> Random.Generator (List (MusicNote, Direction))
        randomTuplesOfMusicNoteDirection length =
            Random.list length <| Random.pair (generatorTreeMusicNote) (Random.map boolToDirection Random.bool)
    in
        Random.andThen randomTuplesOfMusicNoteDirection generatorRandomListLength


generatorTuplesOfIntNode_Direction : Random.Generator (List (IntNode, Direction))
generatorTuplesOfIntNode_Direction =
    let
        tuples : Int -> Random.Generator (List (IntNode, Direction))
        tuples length =
            Random.list length <| Random.pair (generatorIntNode) (Random.map boolToDirection Random.bool)
    in
        Random.andThen tuples generatorRandomListLength


generatorTuplesOfBigIntNode_Direction : Random.Generator (List (BigIntNode, Direction))
generatorTuplesOfBigIntNode_Direction =
    let
        tuples : Int -> Random.Generator (List (BigIntNode, Direction))
        tuples length =
            Random.list length <| Random.pair (generatorBigIntNode) (Random.map boolToDirection Random.bool)
    in
        Random.andThen tuples generatorRandomListLength


generatorTuplesOfStringNode_Direction : Random.Generator (List (StringNode, Direction))
generatorTuplesOfStringNode_Direction =
    let
        tuples : Int -> Random.Generator (List (StringNode, Direction))
        tuples length =
            Random.list length <| Random.pair (generatorStringNode) (Random.map boolToDirection Random.bool)
    in
        Random.andThen tuples generatorRandomListLength


generatorTuplesOfBoolNode_Direction : Random.Generator (List (BoolNode, Direction))
generatorTuplesOfBoolNode_Direction =
    let
        tuples : Int -> Random.Generator (List (BoolNode, Direction))
        tuples length =
            Random.list length <| Random.pair (generatorBoolNode) (Random.map boolToDirection Random.bool)
    in
        Random.andThen tuples generatorRandomListLength


generatorTuplesOfNodeVariety_Direction : Random.Generator (List (NodeVariety, Direction))
generatorTuplesOfNodeVariety_Direction =
    let
        tuples : Int -> Random.Generator (List (NodeVariety, Direction))
        tuples length =
            Random.list length <| Random.pair (generatorNodeVariety) (Random.map boolToDirection Random.bool)
    in
        Random.andThen tuples generatorRandomListLength

