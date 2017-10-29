module Main exposing (..)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, label, programWithFlags)
import Html.Attributes as A exposing (attribute, property, class, checked, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Random exposing (generate)
import Random.Pcg exposing (Seed, initialSeed)
import Uuid exposing (Uuid, uuidGenerator)
import BigInt exposing (BigInt, fromInt)
import Debouncer exposing (DebouncerState, SelfMsg, bounce, create, process)
import Time exposing (Time, millisecond)
import EveryDict exposing (EveryDict, fromList, get, update)
import Basics.Extra exposing (maxSafeInteger)

import Model exposing (Model)
import Msg exposing (Msg(..))
import IntView exposing (IntView(..))
import DropdownAction exposing (DropdownAction(..))
import BTreeUniformType exposing (BTreeUniformType(..), toLength, toIsIntPrime, nodeValOperate, setTreePlayerParams, displayString)
import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, nodeValOperate, hasAnyIntNodes, displayString)
import BTree exposing (BTree(..), Direction(..), TraversalOrder(..), fromListBy, insertAsIsBy, fromListAsIsBy, fromListAsIs_directed, singleton, toTreeDiagramTree)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..), mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)
import TreePlayerParams exposing (defaultTreePlayerParams)
import Ports exposing (port_startPlayNote, port_donePlayNote, port_donePlayNotes, port_disconnectAll)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import Generator exposing (generatorDelta, generatorExponent, generateIds, generatorTreeMusicNotes, generatorIntNodes, generatorBigIntNodes, generatorStringNodes, generatorBoolNodes, generatorNodeVarieties, generatorTuplesOfMusicNoteDirection, generatorTuplesOfIntNode_Direction, generatorTuplesOfBigIntNode_Direction, generatorTuplesOfStringNode_Direction, generatorTuplesOfBoolNode_Direction, generatorTuplesOfNodeVariety_Direction)
import Dashboard exposing (viewDashboard)
------------------------------------------------

initialModel: Model
initialModel =
    { intTree = BTreeInt <|
        Node (IntNodeVal <| toMaybeSafeInt <| maxSafeInteger)
            (singleton <| IntNodeVal <| toMaybeSafeInt 4)
            (Node (IntNodeVal <| toMaybeSafeInt -9)
                Empty
                (singleton <| IntNodeVal <| toMaybeSafeInt 4)
            )
    , bigIntTree = BTreeBigInt <|
        Node (BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger)
            (singleton <| BigIntNodeVal <| BigInt.fromInt 4)
            (Node (BigIntNodeVal <| BigInt.fromInt -9)
                Empty
                (singleton <| BigIntNodeVal <| BigInt.fromInt 4)
            )
    , stringTree = BTreeString <|
        Node (StringNodeVal <| "maxSafeInteger")
            (singleton <| StringNodeVal <| "four")
            (Node (StringNodeVal <| "-nine")
                Empty
                (singleton <| StringNodeVal <| "four")
            )
    , boolTree = BTreeBool <|
        Node (BoolNodeVal <| Just True)
            (singleton <| BoolNodeVal <| Just True)
            (Node (BoolNodeVal <| Just False)
                Empty
                (Node (BoolNodeVal <| Just True)
                    Empty
                    (singleton <| BoolNodeVal <| Just False)
                )
            )
    , initialMusicNoteTree = BTreeMusicNotePlayer defaultTreePlayerParams Empty -- placeholder
    , musicNoteTree = BTreeMusicNotePlayer defaultTreePlayerParams Empty -- placeholder
    , variedTree = BTreeVaried <|
        Node (BigIntVariety <| BigIntNodeVal <| BigInt.fromInt maxSafeInteger)
            (Node (StringVariety <| StringNodeVal <| "A")
                (singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                (singleton <| IntVariety <| IntNodeVal <| toMaybeSafeInt 123)
            )
            ((Node (BoolVariety <| BoolNodeVal <| Just True))
                (singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote <| MidiNumber 57)
                (singleton <| BoolVariety <| BoolNodeVal <| Just True)
            )
    , intTreeCache = BTreeInt Empty
    , bigIntTreeCache = BTreeBigInt Empty
    , stringTreeCache = BTreeString Empty
    , boolTreeCache = BTreeBool Empty
    , musicNoteTreeCache = BTreeMusicNotePlayer defaultTreePlayerParams Empty
    , variedTreeCache = BTreeVaried Empty
    , delta = 1
    , exponent = 2
    , isPlayNotes = False
    , isTreeCaching = False
    , directionForSort = Left
    , directionForRandom = Left
    , intView = IntView
    , uuidSeed = initialSeed 0 -- placeholder
    , isShowDropdown = EveryDict.fromList
        [ (Play, False)
        , (Sort, False)
        , (Random, False)
        ]
    , isMouseEnteredDropdown = EveryDict.fromList
        [ (Play, False)
        , (Sort, False)
        , (Random, False)
        ]
    , menuDropdownDebouncer = Debouncer.create (5 * Time.millisecond)
    }


idedMusicNoteTree : Seed -> (List MusicNotePlayer -> BTree MusicNotePlayer) -> List MusicNote -> (BTreeUniformType, Seed)
idedMusicNoteTree startSeed listToTree notes =
    let
        ( ids, endSeed ) = generateIds (List.length notes) startSeed
        fn = \id note -> MusicNotePlayer.idedOn (Just id) note

        tree = List.map2 fn ids notes
            |> listToTree
            |> notePlayerOn
    in
        ( tree, endSeed )


idedMusicNoteDirectedTree : Seed -> (List (MusicNotePlayer, Direction) -> BTree MusicNotePlayer) -> List (MusicNote, Direction) -> (BTreeUniformType, Seed)
idedMusicNoteDirectedTree startSeed directedListToTree directedNotes =
    let
        ( ids, endSeed ) = generateIds (List.length directedNotes) startSeed
        fn = \id (note, direction) -> (MusicNotePlayer.idedOn (Just id) note, direction)

        tree = List.map2 fn ids directedNotes
            |> directedListToTree
            |> notePlayerOn
    in
        ( tree, endSeed )


notePlayerOn : BTree MusicNotePlayer -> BTreeUniformType
notePlayerOn bTree =
    bTree
        |> BTree.map (\player -> MusicNoteNodeVal player)
        |> BTreeMusicNotePlayer defaultTreePlayerParams


init : Int -> ( Model, Cmd Msg )
init jsSeed =
    let
        startSeed : Seed
        startSeed = initialSeed jsSeed

        listToTree : List MusicNotePlayer -> BTree MusicNotePlayer
        listToTree = BTree.fromListBy MusicNotePlayer.sorter

        initialMusicNotes : List MusicNote
        initialMusicNotes =
            [65, 64, 61, 64, 67, 57, 58]
                |> List.map (\i -> MusicNote <| MidiNumber i)

        ( musicNoteTree, uuidSeed ) = idedMusicNoteTree startSeed listToTree initialMusicNotes
    in
        (   { initialModel
            | initialMusicNoteTree = musicNoteTree
            , musicNoteTree = musicNoteTree
            , uuidSeed = uuidSeed
            }
        ,
        Cmd.none
        )


view : Model -> Html Msg
view model =
    div [ classes
            []
        ]
        [ tachyons.css
        , viewHeader model
        , viewMain model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    header
        [ classes
            [ T.bg_green
            , T.fixed
            , T.w_100
            , T.h3
            , T.f2
            , T.ph3
            , T.pv2
            , T.b
            , T.pl2
            , T.pr2
            , T.z_max
            , T.tc
            ]
        ]
        [ span
            [ classes
                [ T.black
                , T.bg_light_green
                , T.hover_light_green
                , T.hover_bg_black
                ]
            ]
            [ text "Binary Tree" ]
        , span
            [ classes
                [ T.light_green
                , T.bg_black
                , T.hover_black
                , T.hover_bg_light_green
                , ml2
                ]
            ]
            [ text "Playground" ]
        , span
            [ classes
                [ T.fr
                , T.pr2
                , T.pt2
                , T.f4
                , T.grow_large
                ]
            ]
            [ a
                [ href "https://github.com/pdavidow/btree", target "_blank" ]
                [ text "Github" ]
            ]
        ]


viewMain : Model -> Html Msg
viewMain model =
    main_
        [ classes
            [ T.pt5
            , T.pb0
            , T.w_100
            ]
        ]
        [ viewDashboard model
        ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NodeValueOperate operation ->
            (model
                |> nodeValOperateOnUniformTrees operation
                |> nodeValOperateOnVariedTrees operation
            ) ! []


        SortUniformTrees direction ->
            (sortUniformTrees direction model) ! []

        RemoveDuplicates ->
            (deDuplicate model) ! []

        Delta s ->
            { model | delta = intFromInput s } ! []

        Exponent s ->
            { model | exponent = intFromInput s } ! []

        RequestRandomTrees direction ->
            { model
            | directionForRandom = direction
            } ! [ Cmd.batch
                    [ Random.generate ReceiveRandomTreeMusicNotes generatorTreeMusicNotes
                    , Random.generate ReceiveRandomIntNodes generatorIntNodes
                    , Random.generate ReceiveRandomBigIntNodes generatorBigIntNodes
                    , Random.generate ReceiveRandomStringNodes generatorStringNodes
                    , Random.generate ReceiveRandomBoolNodes generatorBoolNodes
                    , Random.generate ReceiveRandomNodeVarieties generatorNodeVarieties
                    ]
                ]

        RequestRandomTreesWithRandomInsertDirection ->
            model !
                [ Cmd.batch
                    [ Random.generate ReceiveRandomTuplesOfMusicNote_Direction generatorTuplesOfMusicNoteDirection
                    , Random.generate ReceiveRandomTuplesOfIntNode_Direction generatorTuplesOfIntNode_Direction
                    , Random.generate ReceiveRandomTuplesOfBigIntNode_Direction generatorTuplesOfBigIntNode_Direction
                    , Random.generate ReceiveRandomTuplesOfStringNode_Direction generatorTuplesOfStringNode_Direction
                    , Random.generate ReceiveRandomTuplesOfBoolNode_Direction generatorTuplesOfBoolNode_Direction
                    , Random.generate ReceiveRandomTuplesOfNodeVariety_Direction generatorTuplesOfNodeVariety_Direction
                    ]
                ]

        RequestRandomScalars ->
            model !
                [ Cmd.batch
                    [ Random.generate ReceiveRandomDelta generatorDelta
                    , Random.generate ReceiveRandomExponent generatorExponent
                    ]
                ]

        ReceiveRandomTreeMusicNotes list ->
            let
                listToTree : List a -> BTree a
                listToTree = BTree.fromListAsIsBy model.directionForRandom

                ( musicNoteTree, uuidSeed ) = idedMusicNoteTree model.uuidSeed listToTree list
            in
                { model
                | musicNoteTree = musicNoteTree
                , uuidSeed = uuidSeed
                } ! []

        ReceiveRandomIntNodes list ->
            let
                tree = list
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTreeInt
            in
                { model
                | intTree = tree
                } ! []

        ReceiveRandomBigIntNodes list ->
            let
                tree = list
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTreeBigInt
            in
                { model
                | bigIntTree = tree
                } ! []

        ReceiveRandomStringNodes list ->
            let
                tree = list
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTreeString
            in
                { model
                | stringTree = tree
                } ! []

        ReceiveRandomBoolNodes list ->
            let
                tree = list
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTreeBool
            in
                { model
                | boolTree = tree
                } ! []

        ReceiveRandomNodeVarieties list ->
            let
                tree = list
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTreeVaried
            in
                { model
                | variedTree = tree
                } ! []

        ReceiveRandomTuplesOfMusicNote_Direction list ->
            let
                listToTree : List (a, Direction) -> BTree a
                listToTree = BTree.fromListAsIs_directed

                ( musicNoteTree, uuidSeed ) = idedMusicNoteDirectedTree model.uuidSeed listToTree list
            in
                { model
                | musicNoteTree = musicNoteTree
                , uuidSeed = uuidSeed
                } ! []

        ReceiveRandomTuplesOfIntNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BTreeInt
            in
                { model
                | intTree = tree
                } ! []

        ReceiveRandomTuplesOfBigIntNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BTreeBigInt
            in
                { model
                | bigIntTree = tree
                } ! []

        ReceiveRandomTuplesOfStringNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BTreeString
            in
                { model
                | stringTree = tree
                } ! []

        ReceiveRandomTuplesOfBoolNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BTreeBool
            in
                { model
                | boolTree = tree
                } ! []

        ReceiveRandomTuplesOfNodeVariety_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BTreeVaried
            in
                { model
                | variedTree = tree
                } ! []

        ReceiveRandomDelta i ->
            { model | delta = i } ! []

        ReceiveRandomExponent i ->
             { model | exponent = i } ! []

        StartShowIsIntPrime ->
            (   { model
                | isTreeCaching = True
                }
                    |> cacheAllTrees
                    |> morphToMbUniformTrees BTreeUniformType.toIsIntPrime
                    |> morphToVariedTrees BTreeVariedType.toIsIntPrime
            ) ! []

        StopShowIsIntPrime ->
            let
                newModel = if model.isTreeCaching
                    then
                        { model
                        | isTreeCaching = False
                        }
                            |> unCacheAllTrees
                    else
                        model
            in
                newModel ! []

        StartShowLength ->
            (   { model
                | isTreeCaching = True
                }
                    |> cacheAllTrees
                    |> morphToMbUniformTrees BTreeUniformType.toLength
                    |> morphToVariedTrees BTreeVariedType.toLength
            ) ! []

        StopShowLength ->
            let
                newModel = if model.isTreeCaching
                    then
                        { model
                        | isTreeCaching = False
                        }
                            |> unCacheAllTrees
                    else
                        model
            in
                newModel ! []

        PlayNotes order ->
            let
                fn = \params -> {params | traversalOrder = order}
                musicNoteTree = setTreePlayerParams fn model.musicNoteTree
            in
                { model
                | musicNoteTree = musicNoteTree
                , isPlayNotes = True
                } ! [treeMusicPlay musicNoteTree]

        StartPlayNote id ->
            let
                mbUuid = Uuid.fromString id

                updatedTree = case mbUuid of
                    Just uuid ->
                       startPlayNote uuid model.musicNoteTree

                    Nothing ->
                        model.musicNoteTree
            in
                { model | musicNoteTree = updatedTree } ! []


        DonePlayNote id ->
            let
                mbUuid = Uuid.fromString id

                updatedTree = case mbUuid of
                    Just uuid ->
                       donePlayNote uuid model.musicNoteTree

                    Nothing ->
                        model.musicNoteTree
            in
                { model | musicNoteTree = updatedTree } ! []

        DonePlayNotes () ->
            { model | isPlayNotes = False } ! []

        StopPlayNotes ->
            let
                updatedTree = donePlayNotes model.musicNoteTree
            in
                { model
                | isPlayNotes = False
                , musicNoteTree = updatedTree
                } ! [port_disconnectAll ()]

        SwitchToIntView intView ->
            { model | intView = intView } ! []

        MouseEnteredButton action ->
            let
                isShowDropdown = EveryDict.update action (\mbVal -> Just True) model.isShowDropdown
            in
                { model| isShowDropdown = isShowDropdown } ! []

        MouseLeftButton action ->
            waitPriorToCheckingIfMouseEnteredDropdown (CheckIfMouseEnteredDropdown action) model

        MouseEnteredDropdown action ->
            let
                isMouseEnteredDropdown = EveryDict.update action (\mbVal -> Just True) model.isMouseEnteredDropdown
            in
                { model| isMouseEnteredDropdown = isMouseEnteredDropdown } ! []

        MouseLeftDropdown action ->
            let
                isShowDropdown = EveryDict.update action (\mbVal -> Just False) model.isShowDropdown
                isMouseEnteredDropdown = EveryDict.update action (\mbVal -> Just False) model.isMouseEnteredDropdown
            in
                { model
                | isShowDropdown = isShowDropdown
                , isMouseEnteredDropdown = isMouseEnteredDropdown
                } ! []


        CheckIfMouseEnteredDropdown action ->
            let
                theMbBool = EveryDict.get action model.isMouseEnteredDropdown
                isShowDropdown = EveryDict.update action (\mbBool -> theMbBool) model.isShowDropdown
            in
                { model| isShowDropdown = isShowDropdown } ! []

        DebouncerSelfMsg debouncerMsg ->
            let
                ( debouncer, cmd ) =
                    model.menuDropdownDebouncer |> Debouncer.process debouncerMsg
            in
                { model | menuDropdownDebouncer = debouncer } ! [cmd]

        Reset ->
            let
                tree = model.initialMusicNoteTree
                seed = model.uuidSeed
            in
                { initialModel
                | initialMusicNoteTree = tree
                , musicNoteTree = tree
                , uuidSeed = seed
                } ! [port_disconnectAll ()]


waitPriorToCheckingIfMouseEnteredDropdown : Msg -> Model -> (Model, Cmd Msg)
waitPriorToCheckingIfMouseEnteredDropdown msg model =
    let
        (debouncer, debouncerCmd) =
            model.menuDropdownDebouncer |> Debouncer.bounce { id = toString msg, msgToSend = msg }
    in
        { model | menuDropdownDebouncer = debouncer } ! [debouncerCmd |> Cmd.map DebouncerSelfMsg]


cacheAllTrees : Model -> Model
cacheAllTrees model =
    {model
        | intTreeCache = model.intTree
        , bigIntTreeCache = model.bigIntTree
        , stringTreeCache = model.stringTree
        , boolTreeCache = model.boolTree
        , musicNoteTreeCache = model.musicNoteTree
        , variedTreeCache = model.variedTree
    }


unCacheAllTrees : Model -> Model
unCacheAllTrees model =
    {model
        | intTree = model.intTreeCache
        , bigIntTree = model.bigIntTreeCache
        , stringTree = model.stringTreeCache
        , boolTree= model.boolTreeCache
        , musicNoteTree = model.musicNoteTreeCache
        , variedTree = model.variedTreeCache
    }


changeUniformTrees : (BTreeUniformType -> BTreeUniformType) -> Model -> Model
changeUniformTrees fn model =
    {model
        | intTree = fn model.intTree
        , bigIntTree = fn model.bigIntTree
        , stringTree = fn model.stringTree
        , boolTree = fn model.boolTree
        , musicNoteTree = fn model.musicNoteTree
    }


changeVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
changeVariedTrees fn model =
    {model
        | variedTree = fn model.variedTree
    }


nodeValOperateOnUniformTrees : Operation -> Model -> Model
nodeValOperateOnUniformTrees operation model =
    changeUniformTrees (BTreeUniformType.nodeValOperate operation) model


nodeValOperateOnVariedTrees : Operation -> Model -> Model
nodeValOperateOnVariedTrees operation model =
    changeVariedTrees (BTreeVariedType.nodeValOperate operation) model


sortUniformTrees : Direction -> Model -> Model
sortUniformTrees direction model =
    changeUniformTrees (BTreeUniformType.sort direction) model


deDuplicate : Model -> Model
deDuplicate model =
    model
        |> deDuplicateUniformTrees
        |> deDuplicateVariedTrees


deDuplicateUniformTrees : Model -> Model
deDuplicateUniformTrees model =
    let
        fn = BTreeUniformType.deDuplicate
    in
        changeUniformTrees fn model


deDuplicateVariedTrees : Model -> Model
deDuplicateVariedTrees model =
    let
        fn = BTreeVariedType.deDuplicate
    in
        changeVariedTrees fn model


morphToMbUniformTrees : (BTreeUniformType -> Maybe BTreeUniformType) -> Model -> Model
morphToMbUniformTrees fn model =
    let
        defaultMorph = \tree -> defaultMorphUniformTree fn tree
    in
        changeUniformTrees defaultMorph model


morphToVariedTrees : (BTreeVariedType -> BTreeVariedType) -> Model -> Model
morphToVariedTrees fn model =
    changeVariedTrees fn model


defaultMorphUniformTree : (BTreeUniformType -> Maybe BTreeUniformType) -> BTreeUniformType -> BTreeUniformType
defaultMorphUniformTree fn tree =
    Maybe.withDefault (BTreeUniformType.toNothing tree) (fn tree)


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ port_startPlayNote StartPlayNote
        , port_donePlayNote DonePlayNote
        , port_donePlayNotes DonePlayNotes
        ]


main : Program Int Model Msg
main =
  Html.programWithFlags -- using programWithFlags to get seed from JS
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
