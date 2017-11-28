module Main exposing (..)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, label, programWithFlags)
import Html.Attributes as A exposing (attribute, property, class, checked, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Random exposing (generate)
import Random.Pcg exposing (Seed, initialSeed)
import Uuid exposing (Uuid, uuidGenerator)
import BigInt exposing (BigInt, fromInt)
import Time exposing (Time, millisecond)
import EveryDict exposing (EveryDict, fromList, get, update)
import Basics.Extra exposing (maxSafeInteger)

import Model exposing (Model)
import Msg exposing (Msg(..))
import IntView exposing (IntView(..))
import BTreeUniformType exposing (BTreeUniform(..), IntTree(..), BigIntTree(..), StringTree(..), BoolTree(..), MusicNotePlayerTree(..), NothingTree(..), toLength, toIsIntPrime, nodeValOperate, displayString, intTreeFrom, bigIntTreeFrom, stringTreeFrom, boolTreeFrom, musicNotePlayerTreeFrom)
import BTreeVariedType exposing (BTreeVaried(..), toLength, toIsIntPrime, nodeValOperate, hasAnyIntNodes, displayString)
import BTree exposing (BTree(..), Direction(..), TraversalOrder(..), fromListBy, insertAsIsBy, fromListAsIsBy, fromListAsIs_directed, singleton, toTreeDiagramTree)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNote exposing (MusicNote(..), MidiNumber(..), mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), sorter)
import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)
import TreePlayerParams exposing (PlaySpeed(..), defaultTreePlayerParams)
import Ports exposing (port_startPlayNote, port_donePlayNote, port_donePlayNotes, port_disconnectAll)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
import Generator exposing (generatorDelta, generatorExponent, generateIds, generatorTreeMusicNotes, generatorIntNodes, generatorBigIntNodes, generatorStringNodes, generatorBoolNodes, generatorNodeVarieties, generatorTuplesOfMusicNoteDirection, generatorTuplesOfIntNode_Direction, generatorTuplesOfBigIntNode_Direction, generatorTuplesOfStringNode_Direction, generatorTuplesOfBoolNode_Direction, generatorTuplesOfNodeVariety_Direction)
import Dashboard exposing (viewDashboardWithTreesUnderneath)
import TreeRandomInsertStyle exposing (TreeRandomInsertStyle)
------------------------------------------------

initialModel: Model
initialModel =
    { intTree = IntTree <|
        Node (IntNodeVal <| toMaybeSafeInt <| maxSafeInteger)
            (singleton <| IntNodeVal <| toMaybeSafeInt 4)
            (Node (IntNodeVal <| toMaybeSafeInt -9)
                Empty
                (singleton <| IntNodeVal <| toMaybeSafeInt 4)
            )
    , bigIntTree = BigIntTree <|
        Node (BigIntNodeVal <| BigInt.fromInt <| maxSafeInteger)
            (singleton <| BigIntNodeVal <| BigInt.fromInt 4)
            (Node (BigIntNodeVal <| BigInt.fromInt -9)
                Empty
                (singleton <| BigIntNodeVal <| BigInt.fromInt 4)
            )
    , stringTree = StringTree <|
        Node (StringNodeVal <| "maxSafeInteger")
            (singleton <| StringNodeVal <| "four")
            (Node (StringNodeVal <| "-nine")
                Empty
                (singleton <| StringNodeVal <| "four")
            )
    , boolTree = BoolTree <|
        Node (BoolNodeVal <| Just True)
            (singleton <| BoolNodeVal <| Just True)
            (Node (BoolNodeVal <| Just False)
                Empty
                (Node (BoolNodeVal <| Just True)
                    Empty
                    (singleton <| BoolNodeVal <| Just False)
                )
            )
    , initialMusicNoteTree = MusicNotePlayerTree defaultTreePlayerParams Empty -- placeholder
    , musicNoteTree = MusicNotePlayerTree defaultTreePlayerParams Empty -- placeholder
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

    , intTreeMorph = UniformNothing <| NothingTree Empty
    , bigIntTreeMorph = UniformNothing <| NothingTree Empty
    , stringTreeMorph = UniformNothing <| NothingTree Empty
    , boolTreeMorph = UniformNothing <| NothingTree Empty
    , musicNoteTreeMorph = UniformNothing <| NothingTree Empty
    , variedTreeCache = BTreeVaried Empty

    , masterPlaySpeed = Slow
    , masterTraversalOrder = InOrder
    , delta = 1
    , exponent = 2
    , isPlayNotes = False
    , isTreeMorphing = False
    , directionForSort = BTree.Left
    , treeRandomInsertStyle = TreeRandomInsertStyle.Left
    , intView = IntView
    , uuidSeed = initialSeed 0 -- placeholder
    }


idedMusicNoteTree : Seed -> (List MusicNotePlayer -> BTree MusicNotePlayer) -> List MusicNote -> (MusicNotePlayerTree, Seed)
idedMusicNoteTree startSeed listToTree notes =
    let
        ( ids, endSeed ) = generateIds (List.length notes) startSeed
        fn = \id note -> MusicNotePlayer.idedOn (Just id) note

        tree = List.map2 fn ids notes
            |> listToTree
            |> notePlayerOn
    in
        ( tree, endSeed )


idedMusicNoteDirectedTree : Seed -> (List (MusicNotePlayer, Direction) -> BTree MusicNotePlayer) -> List (MusicNote, Direction) -> (MusicNotePlayerTree, Seed)
idedMusicNoteDirectedTree startSeed directedListToTree directedNotes =
    let
        ( ids, endSeed ) = generateIds (List.length directedNotes) startSeed
        fn = \id (note, direction) -> (MusicNotePlayer.idedOn (Just id) note, direction)

        tree = List.map2 fn ids directedNotes
            |> directedListToTree
            |> notePlayerOn
    in
        ( tree, endSeed )


notePlayerOn : BTree MusicNotePlayer -> MusicNotePlayerTree
notePlayerOn bTree =
    bTree
        |> BTree.map (\player -> MusicNoteNodeVal player)
        |> MusicNotePlayerTree defaultTreePlayerParams


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
        [ viewDashboardWithTreesUnderneath model
        ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NodeValueOperate operation ->
            (model
                |> nodeValOperateOnUniformTrees operation
                |> nodeValOperateOnVariedTrees operation
            ) ! []


        SortUniformTrees ->
            (sortUniformTrees model) ! []

        RemoveDuplicates ->
            (deDuplicate model) ! []

        Delta s ->
            { model | delta = intFromInput s } ! []

        Exponent s ->
            { model | exponent = intFromInput s } ! []

        RequestRandomTrees ->
            let
                randomInsert =
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

                directedInsert =
                    model !
                        [ Cmd.batch
                            [ Random.generate ReceiveRandomTreeMusicNotes generatorTreeMusicNotes
                            , Random.generate ReceiveRandomIntNodes generatorIntNodes
                            , Random.generate ReceiveRandomBigIntNodes generatorBigIntNodes
                            , Random.generate ReceiveRandomStringNodes generatorStringNodes
                            , Random.generate ReceiveRandomBoolNodes generatorBoolNodes
                            , Random.generate ReceiveRandomNodeVarieties generatorNodeVarieties
                            ]
                        ]
            in
                case model.treeRandomInsertStyle of
                    TreeRandomInsertStyle.Random -> randomInsert
                    TreeRandomInsertStyle.Right -> directedInsert
                    TreeRandomInsertStyle.Left -> directedInsert

        RequestRandomScalars ->
            model !
                [ Cmd.batch
                    [ Random.generate ReceiveRandomDelta generatorDelta
                    , Random.generate ReceiveRandomExponent generatorExponent
                    ]
                ]

        ReceiveRandomTreeMusicNotes list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                listToTree : List a -> BTree a
                listToTree = BTree.fromListAsIsBy direction

                ( musicNoteTree, uuidSeed ) = idedMusicNoteTree model.uuidSeed listToTree list
            in
                { model
                | musicNoteTree = musicNoteTree
                , uuidSeed = uuidSeed
                } ! []

        ReceiveRandomIntNodes list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                tree = list
                    |> BTree.fromListAsIsBy direction
                    |> IntTree
            in
                { model
                | intTree = tree
                } ! []

        ReceiveRandomBigIntNodes list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                tree = list
                    |> BTree.fromListAsIsBy direction
                    |> BigIntTree
            in
                { model
                | bigIntTree = tree
                } ! []

        ReceiveRandomStringNodes list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                tree = list
                    |> BTree.fromListAsIsBy direction
                    |> StringTree
            in
                { model
                | stringTree = tree
                } ! []

        ReceiveRandomBoolNodes list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                tree = list
                    |> BTree.fromListAsIsBy direction
                    |> BoolTree
            in
                { model
                | boolTree = tree
                } ! []

        ReceiveRandomNodeVarieties list ->
            let
                direction = directionForTreeRandomInsertStyle model.treeRandomInsertStyle

                tree = list
                    |> BTree.fromListAsIsBy direction
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
                    |> IntTree
            in
                { model
                | intTree = tree
                } ! []

        ReceiveRandomTuplesOfBigIntNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BigIntTree
            in
                { model
                | bigIntTree = tree
                } ! []

        ReceiveRandomTuplesOfStringNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> StringTree
            in
                { model
                | stringTree = tree
                } ! []

        ReceiveRandomTuplesOfBoolNode_Direction list ->
            let
                tree = list
                    |> BTree.fromListAsIs_directed
                    |> BoolTree
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
                | isTreeMorphing = True
                }
                    |> cacheTreesFor_ShowIsIntPrime
                    |> morphToMbUniformTrees BTreeUniformType.toIsIntPrime
                    |> morphToVariedTrees BTreeVariedType.toIsIntPrime
            ) ! []

        StopShowIsIntPrime ->
            let
                newModel = if model.isTreeMorphing
                    then
                        { model
                        | isTreeMorphing = False
                        }
                            |> unCacheTreesFor_ShowIsIntPrime
                    else
                        model
            in
                newModel ! []

        StartShowLength ->
            (   { model
                | isTreeMorphing = True
                }
                    |> cacheTreesFor_ShowLength
                    |> morphToMbUniformTrees BTreeUniformType.toLength
                    |> morphToVariedTrees BTreeVariedType.toLength
            ) ! []

        StopShowLength ->
            let
                newModel = if model.isTreeMorphing
                    then
                        { model
                        | isTreeMorphing = False
                        }
                            |> unCacheTreesFor_ShowLength
                    else
                        model
            in
                newModel ! []

        TogglePlayNotes ->
            case model.isPlayNotes of
                True -> stopPlayNotes model
                False -> playNotes model

        ChangeTraversalOrder order ->
            { model | masterTraversalOrder = order } ! []

        ChangePlaySpeed speed ->
            { model | masterPlaySpeed = speed } ! []

        ChangeSortDirection direction ->
            { model | directionForSort = direction } ! []

        ChangeTreeRandomInsertStyle style ->
            { model | treeRandomInsertStyle = style } ! []

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

        SwitchToIntView intView ->
            { model | intView = intView } ! []

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


directionForTreeRandomInsertStyle : TreeRandomInsertStyle -> Direction
directionForTreeRandomInsertStyle style =
    case style of
        TreeRandomInsertStyle.Random -> BTree.Left -- should never get here
        TreeRandomInsertStyle.Right -> BTree.Right
        TreeRandomInsertStyle.Left -> BTree.Left


cacheTreesFor_ShowIsIntPrime : Model -> Model
cacheTreesFor_ShowIsIntPrime model =
    cacheVariedTree model


cacheTreesFor_ShowLength : Model -> Model
cacheTreesFor_ShowLength model =
    cacheVariedTree model


unCacheTreesFor_ShowIsIntPrime : Model -> Model
unCacheTreesFor_ShowIsIntPrime model =
    unCacheVariedTree model


unCacheTreesFor_ShowLength : Model -> Model
unCacheTreesFor_ShowLength model =
    unCacheVariedTree model


cacheVariedTree : Model -> Model
cacheVariedTree model =
    {model | variedTreeCache = model.variedTree}


unCacheVariedTree : Model -> Model
unCacheVariedTree model =
    {model | variedTree = model.variedTreeCache}


morphUniformTrees : (BTreeUniform -> BTreeUniform) -> Model -> Model
morphUniformTrees fn model =
    {model
        | intTreeMorph = fn <| UniformInt model.intTree
        , bigIntTreeMorph = fn <| UniformBigInt model.bigIntTree
        , stringTreeMorph = fn <| UniformString model.stringTree
        , boolTreeMorph = fn <| UniformBool model.boolTree
        , musicNoteTreeMorph = fn <| UniformMusicNotePlayer model.musicNoteTree
    }


changeUniformTrees : (BTreeUniform -> BTreeUniform) -> Model -> Model
changeUniformTrees fn model =
    {model
        | intTree = intTreeFrom <| fn <| UniformInt model.intTree
        , bigIntTree = bigIntTreeFrom <| fn <| UniformBigInt model.bigIntTree
        , stringTree = stringTreeFrom <| fn <| UniformString model.stringTree
        , boolTree = boolTreeFrom <| fn <| UniformBool model.boolTree
        , musicNoteTree = musicNotePlayerTreeFrom <| fn <| UniformMusicNotePlayer model.musicNoteTree
    }


changeVariedTrees : (BTreeVaried -> BTreeVaried) -> Model -> Model
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


sortUniformTrees : Model -> Model
sortUniformTrees model =
    changeUniformTrees (BTreeUniformType.sort model.directionForSort) model


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


morphToMbUniformTrees : (BTreeUniform -> Maybe BTreeUniform) -> Model -> Model
morphToMbUniformTrees fn model =
    let
        defaultMorph = \tree -> defaultMorphUniformTree fn tree
    in
        morphUniformTrees defaultMorph model


morphToVariedTrees : (BTreeVaried -> BTreeVaried) -> Model -> Model
morphToVariedTrees fn model =
    changeVariedTrees fn model


defaultMorphUniformTree : (BTreeUniform -> Maybe BTreeUniform) -> BTreeUniform -> BTreeUniform
defaultMorphUniformTree fn tree =
    Maybe.withDefault (BTreeUniformType.toNothing tree) (fn tree)


intFromInput : String -> Int
intFromInput string =
    Result.withDefault 0 (String.toInt string)


playNotes : Model -> (Model, Cmd Msg)
playNotes model =
    let
        fn = \params ->
            { params
            | traversalOrder = model.masterTraversalOrder
            , playSpeed = model.masterPlaySpeed
            }

        (MusicNotePlayerTree params bTree) = model.musicNoteTree
        musicNoteTree = MusicNotePlayerTree (fn params) bTree
    in
        { model
        | musicNoteTree = musicNoteTree
        , isPlayNotes = True
        } ! [treeMusicPlay musicNoteTree]


stopPlayNotes : Model -> (Model, Cmd Msg)
stopPlayNotes model =
    let
        updatedTree = donePlayNotes model.musicNoteTree
    in
        { model
        | isPlayNotes = False
        , musicNoteTree = updatedTree
        } ! [port_disconnectAll ()]


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
