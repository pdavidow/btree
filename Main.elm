module Main exposing (..)

import Html exposing (Html, div, span, header, main_, section, article, a, button, text, input, h1, h2, label, programWithFlags)
import Html.Events exposing (onClick, onMouseUp, onMouseDown, onMouseEnter, onMouseLeave, onMouseOver, onMouseOut, onInput)
import Html.Attributes as A exposing (attribute, property, class, checked, style, type_, value, href, target, disabled)
import Tachyons exposing (classes, tachyons)
import Tachyons.Classes as T exposing (..)

import Maybe.Extra exposing (unwrap)
import List.Extra exposing (last)
import Random exposing (int, bool, pair, list, andThen, generate)
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid exposing (Uuid, uuidGenerator)
import Lazy exposing (lazy)
import BigInt exposing (fromInt)
import Debouncer exposing (DebouncerState, SelfMsg, bounce, create, process)
import Time exposing (Time, millisecond)
import EveryDict exposing (EveryDict, fromList, get, update)
import Basics.Extra exposing (maxSafeInteger)

import BTreeUniformType exposing (BTreeUniformType(..), toLength, toIsIntPrime, nodeValOperate, setTreePlayerParams)
import BTreeVariedType exposing (BTreeVariedType(..), toLength, toIsIntPrime, nodeValOperate, hasAnyIntNodes)
import BTree exposing (BTree(..), Direction(..), TraversalOrder(..), fromListBy, insertAsIsBy, fromListAsIsBy, fromListAsIs_directed, singleton, toTreeDiagramTree)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import BTreeView exposing (bTreeUniformTypeDiagram, bTreeVariedTypeDiagram, intNodeEvenColor, intNodeOddColor, unsafeColor)
import UniversalConstants exposing (nothingString)
import MusicNote exposing (MusicNote(..), mbSorter)
import MusicNotePlayer exposing (MusicNotePlayer(..), on, idedOn, sorter)
import TreeMusicPlayer exposing (treeMusicPlay, startPlayNote, donePlayNote, donePlayNotes)
import TreePlayerParams exposing (defaultTreePlayerParams)
import Ports exposing (port_startPlayNote, port_donePlayNote, port_donePlayNotes, port_disconnectAll)
import Lib exposing (IntFlex(..), lazyUnwrap)
import MaybeSafe exposing (MaybeSafe(..), toMaybeSafeInt)
import NodeValueOperation exposing (Operation(..))
------------------------------------------------


type IntView
    = IntView
    | BigIntView
    | BothView


type DropdownAction
    = Play
    | Sort
    | Random


type Msg
    = NodeValueOperate (Operation)
    | SortUniformTrees (Direction)
    | RemoveDuplicates
    | Delta String
    | Exponent String
    | RequestRandomInts (Direction)
    | RequestRandomPairsIntDirection
    | ReceiveRandomInts (List Int)
    | ReceiveRandomPairsIntDirection (List (Int, Direction))
    | RequestRandomDelta
    | ReceiveRandomDelta (Int)
    | StartShowLength
    | StopShowLength
    | StartShowIsIntPrime
    | StopShowIsIntPrime
    | PlayNotes (TraversalOrder)
    | StartPlayNote (String)
    | DonePlayNote (String)
    | DonePlayNotes (())
    | StopPlayNotes
    | SwitchToIntView (IntView)

    | MouseEnteredButton (DropdownAction)
    | MouseLeftButton (DropdownAction)
    | MouseEnteredDropdown (DropdownAction)
    | CheckIfMouseEnteredDropdown (DropdownAction)
    | MouseLeftDropdown (DropdownAction)

    | DebouncerSelfMsg (Debouncer.SelfMsg Msg)
    | Reset


type alias Model =
    { intTree : BTreeUniformType
    , bigIntTree : BTreeUniformType
    , stringTree : BTreeUniformType
    , boolTree : BTreeUniformType
    , initialMusicNoteTree : BTreeUniformType
    , musicNoteTree : BTreeUniformType
    , variedTree : BTreeVariedType
    , intTreeCache : BTreeUniformType
    , bigIntTreeCache : BTreeUniformType
    , stringTreeCache : BTreeUniformType
    , boolTreeCache : BTreeUniformType
    , musicNoteTreeCache : BTreeUniformType
    , variedTreeCache : BTreeVariedType
    , delta : Int
    , exponent : Int
    , isPlayNotes : Bool
    , isTreeCaching : Bool
    , directionForSort : Direction
    , directionForRandom : Direction
    , intView : IntView
    , uuidSeed : Seed
    , isShowDropdown : EveryDict DropdownAction Bool
    , isMouseEnteredDropdown : EveryDict DropdownAction Bool
    , menuDropdownDebouncer : Debouncer.DebouncerState
    }


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
                (singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote 57)
                (singleton <| IntVariety <| IntNodeVal <| toMaybeSafeInt 123)
            )
            ((Node (BoolVariety <| BoolNodeVal <| Just True))
                (singleton <| MusicNoteVariety <| MusicNoteNodeVal <| MusicNotePlayer.on <| MusicNote 57)
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


maxRandomInt = 999
minRandomListLength = 3
maxRandomListLength = 12


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


idedMusicNoteTree : Seed -> (BTreeUniformType, Seed)
idedMusicNoteTree startSeed =
    let
        notes = [MusicNote 65, MusicNote 64, MusicNote 61, MusicNote 64, MusicNote 67, MusicNote 57, MusicNote 58]
        ( ids, endSeed ) = generateIds (List.length notes) startSeed

        tree = List.map2 (\id note -> MusicNotePlayer.idedOn (Just id) note) ids notes
            |> BTree.fromListBy MusicNotePlayer.sorter
            |> BTree.map (\player -> MusicNoteNodeVal player)
            |> BTreeMusicNotePlayer defaultTreePlayerParams
    in
        ( tree, endSeed )


init : Int -> ( Model, Cmd Msg )
init jsSeed =
    let
        ( musicNoteTree, uuidSeed ) = idedMusicNoteTree (initialSeed jsSeed)
    in
        (   {initialModel
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
            [ text "BinaryTree" ]
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
            [ T.pv5
            , T.w_100
            ]
        ]
        [ viewDashboard model
        , viewTrees model
        ]


viewDashboard : Model -> Html Msg
viewDashboard model =
    section
        [ classes
            [ T.fixed
            , T.w_100
            , T.f3
            , T.pa3
            , T.z_max
           ]
        ]
        [ section
            [ classes
                [ T.pa1
                , T.bg_washed_yellow
                ]
            ]
            ( viewDashboardTop model )
        , section
            [ classes
                [ T.pa1
                , T.bg_washed_red
                ]
            ]
            ( viewDashboardBottom model )
        ]


viewDashboardTop : Model -> List (Html Msg)
viewDashboardTop model =
    let
        isPlayDisabled = not <| isEnablePlayNotesWidgetry model
    in
        [ span
            [classes [T.mh2]]
            [ div
                [ classes
                    [ T.relative
                    , T.dib
                    ]
                ]
                [ button
                    [ classes
                        ([ T.hover_bg_light_green
                        ] ++ (if Maybe.withDefault False (EveryDict.get Play model.isShowDropdown) then [T.bg_light_green] else []))
                    , disabled isPlayDisabled
                    , onMouseEnter <| MouseEnteredButton Play
                    , onMouseLeave <| MouseLeftButton Play
                    ]
                    [ text "Play" ]
                , div
                    [ classes
                         [ T.absolute
                         , (if Maybe.withDefault False (EveryDict.get Play model.isShowDropdown) then T.db else T.dn)
                         , T.ba
                         , T.w5
                         ]
                    , onMouseEnter <| MouseEnteredDropdown Play
                    , onMouseLeave <| MouseLeftDropdown Play
                    ]
                    [ button
                        [ classes
                            [ T.db
                            , T.hover_bg_light_green
                            , T.pa2
                            , T.tl
                            , w_100
                            ]
                        , disabled isPlayDisabled
                        , onClick <| PlayNotes PreOrder
                        ]
                        [text "Pre-Order"]
                    , button
                        [ classes
                            [ T.db
                            , T.hover_bg_light_green
                            , T.pa2
                            , w_100
                            , T.tl
                            ]
                        , disabled isPlayDisabled
                        , onClick <| PlayNotes InOrder
                        ]
                        [text "In-Order"]
                    , button
                        [ classes
                            [ T.db
                            , T.hover_bg_light_green
                            , T.pa2
                            , T.tl
                            , w_100
                            ]
                        , disabled isPlayDisabled
                        , onClick <| PlayNotes PostOrder
                        ]
                        [text "Post-Order"]
                    ]
                , button
                    [ classes
                        [ T.hover_bg_light_green]
                    , disabled <| not model.isPlayNotes
                    , onClick StopPlayNotes
                    ]
                    [ text "Stop Play" ]
                ]
            ]
    , span
        [classes [T.mh2]]
        [ button
            [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <|Increment model.delta, disabled model.isPlayNotes]
            [text "+ Delta"]
        , button
            [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <| Decrement model.delta, disabled model.isPlayNotes]
            [text "- Delta"]
        , button
            [classes [T.hover_bg_light_green, T.mv1], onClick <| NodeValueOperate <| Raise model.exponent, disabled model.isPlayNotes]
            [text "^ Exp"]
        ]
    , span
        [classes [T.mh2]]
        [ div
            [ classes
                [ T.relative
                , T.dib
                ]
            ]
            [ button
                [ classes
                    ([ T.hover_bg_light_green
                    ] ++ (if Maybe.withDefault False (EveryDict.get Sort model.isShowDropdown) then [T.bg_light_green] else []))
                , disabled model.isPlayNotes
                    , onMouseEnter <| MouseEnteredButton Sort
                    , onMouseLeave <| MouseLeftButton Sort
                ]
                [ text "Sort" ]
            , div
                [ classes
                     [ T.absolute
                     , (if Maybe.withDefault False (EveryDict.get Sort model.isShowDropdown) then T.db else T.dn)
                     , T.ba
                     , T.w5
                     ]
                    , onMouseEnter <| MouseEnteredDropdown Sort
                    , onMouseLeave <| MouseLeftDropdown Sort
                ]
                [ button
                    [ classes
                        [ T.db
                        , T.hover_bg_light_green
                        , T.pa2
                        , w_100
                        , T.tl
                        ]
                    , disabled model.isPlayNotes
                    , onClick <| SortUniformTrees Left
                    ]
                    [text "Left"]
                , button
                    [ classes
                        [ T.db
                        , T.hover_bg_light_green
                        , T.pa2
                        , w_100
                        , T.tl
                        ]
                    , disabled model.isPlayNotes
                    , onClick <| SortUniformTrees Right
                    ]
                    [text "Right"]
                ]
            ]
        , button
            [classes [T.hover_bg_light_green, T.mv1], onClick RemoveDuplicates, disabled model.isPlayNotes]
            [text "Dedup"]
        ]
    , span
        [classes [T.mh2]]
        [ button
            [classes [T.hover_bg_light_green, T.mv1], onMouseDown StartShowIsIntPrime, onMouseUp StopShowIsIntPrime, onMouseLeave StopShowIsIntPrime]
            [text "Prime?"]
        , button
            [classes [T.hover_bg_light_green, T.mv1], onMouseDown StartShowLength, onMouseUp StopShowLength, onMouseLeave StopShowLength]
            [text "Length"]
        ]
    , span
        [ classes [T.mh2] ]
        [ div
            [ classes
                [ T.relative
                , T.dib
                ]
            ]
            [ button
                [ classes
                    ([ T.hover_bg_light_green
                    ] ++ (if Maybe.withDefault False (EveryDict.get Random model.isShowDropdown) then [T.bg_light_green] else []))
                    , onMouseEnter <| MouseEnteredButton Random
                    , onMouseLeave <| MouseLeftButton Random
                ]
                [ text "Random Ints" ]
            , div
                [ classes
                     [ T.absolute
                     , (if Maybe.withDefault False (EveryDict.get Random model.isShowDropdown) then T.db else T.dn)
                     , T.ba
                     , T.w5
                     ]
                    , onMouseEnter <| MouseEnteredDropdown Random
                    , onMouseLeave <| MouseLeftDropdown Random
                ]
                [ button
                    [ classes
                        [ T.db
                        , T.hover_bg_light_green
                        , T.pa2
                        , w_100
                        , T.tl
                        ]
                    , onClick RequestRandomPairsIntDirection
                    ]
                    [text "Insert Random L/R"]
                , div -- divider line
                    [ classes
                        [ T.db
                        , T.w_100
                        , T.bt
                        , T.bw1
                        ]
                    ]
                    []
                , button
                    [ classes
                        [ T.db
                        , T.hover_bg_light_green
                        , T.pa2
                        , w_100
                        , T.tl
                        ]
                    , onClick <| RequestRandomInts Left
                    ]
                    [text "Insert Left"]
                , button
                    [ classes
                        [ T.db
                        , T.hover_bg_light_green
                        , T.pa2
                        , w_100
                        , T.tl
                        ]
                    , onClick <| RequestRandomInts Right
                    ]
                    [text "Insert Right"]
                ]
            ]
        , button
            [classes [T.hover_bg_light_green, T.mv1], onClick RequestRandomDelta]
            [text "Random Delta"]
        ]
    , button
        [classes [T.fr, T.hover_bg_light_yellow, T.mv1, T.mr2], onClick Reset]
        [text "Reset"]
    ]


isEnablePlayNotesWidgetry : Model -> Bool
isEnablePlayNotesWidgetry model =
    not (model.isPlayNotes) && not (BTreeUniformType.isAllNothing model.musicNoteTree)


viewDashboardBottom : Model -> List (Html Msg)
viewDashboardBottom model =
    [ span
        []
        (viewInputs model)
    , span
        [classes [T.pl3]]
        (viewIntTreeChoice model)
    ]


viewInputs : Model -> List (Html Msg)
viewInputs model =
    [ span
        []
        [ text "Delta: "
        , input
            [ classes [T.f4, T.w3]
            , A.type_ "number"
            , A.min "1"
            , value (toString model.delta)
            , onInput Delta
            ]
            []
        ]
    , span
        [classes [T.pl3]]
        [ text "Exp: "
        , input
            [ classes [T.f4, T.w3]
            , A.type_ "number"
            , A.min "1"
            , value (toString model.exponent)
            , onInput Exponent
            ]
            []
        ]
    ]


radioIntView : IntView -> Model -> Html Msg
radioIntView intView model =
    let
        labelFor intView = case intView of
             IntView -> "Int"
             BigIntView -> "BigInt"
             BothView -> "Both"
    in
        label
            [ classes [T.pa2] ]
            [ input
                [ type_ "radio"
                , checked <| model.intView == intView
                , onClick (SwitchToIntView intView)
                ]
                []
            , text <| labelFor intView
            ]


viewIntTreeChoice : Model -> List (Html Msg)
viewIntTreeChoice model =
    [ span
        [ classes [T.pt1, T.pb1, T.mt2, T.mb2, T.f6, T.ba, T.br2] ]
        [ radioIntView IntView model
        , radioIntView BigIntView model
        , radioIntView BothView model
        ]
    ]


viewTrees : Model -> Html Msg
viewTrees model =
    let
        intTreesOfInterest = case model.intView of
            IntView -> [model.intTree]
            BigIntView -> [model.bigIntTree]
            BothView -> [model.intTree, model.bigIntTree]

        intTreeCards = List.map viewUniformTreeCard intTreesOfInterest

        cards = List.concat
            [   [ viewUniformTreeCard model.musicNoteTree
                ]
            ,   intTreeCards
            ,   [ viewUniformTreeCard model.stringTree
                , viewUniformTreeCard model.boolTree
                , viewVariedTreeCard model.variedTree
                ]
            ]
    in
        section
            [ classes
                [ T.cf
                , T.pv6
                , T.flex_auto
                , T.bg_washed_green
               ]
            ]
            cards


viewUniformTreeCard : BTreeUniformType -> Html msg
viewUniformTreeCard bTreeUniformType =
    let
        title = bTreeUniformTitle bTreeUniformType
        status = bTreeUniformStatus bTreeUniformType
        mbLegend = bTreeUniformLegend bTreeUniformType
        mbBgColor = Nothing
        diagram = bTreeUniformTypeDiagram bTreeUniformType
    in
        viewTreeCard title status mbLegend mbBgColor diagram


viewVariedTreeCard : BTreeVariedType -> Html msg
viewVariedTreeCard bTreeVariedType =
    let
        title = "BTreeVaried"
        status = bTreeVariedStatus bTreeVariedType
        mbLegend = bTreeVariedLegend bTreeVariedType
        mbBgColor = Just T.bg_black_05
        diagram = bTreeVariedTypeDiagram bTreeVariedType
    in
        viewTreeCard title status mbLegend mbBgColor diagram


depthStatus : Int -> String
depthStatus depth =
    "depth " ++ toString depth


bTreeUniformTitle : BTreeUniformType -> String
bTreeUniformTitle bTreeUniformType =
    bTreeUniformType
        |> toString
        |> String.split " "
        |> List.head
        |> Maybe.withDefault ""


treeStatus : Int -> Maybe IntFlex -> Html msg
treeStatus depth mbIxSum =
    let
        sumDisplay =
            let
                okSum = \string ->
                    span
                        []
                        [ text string]

                result = \ixSum ->
                    case ixSum of
                        IntVal mbsInt ->
                            MaybeSafe.unwrap
                                (span
                                    [ classes [unsafeColor] ]
                                    [ text "unsafe" ]
                                )
                                (\sum -> okSum <| Basics.toString sum)
                                mbsInt
                        BigIntVal sum ->
                            okSum <| BigInt.toString sum
            in
                Maybe.Extra.unwrap
                    [span [][]]
                    (\ixSum ->
                        [ span
                            []
                            [ text "; sum " ]
                        , result ixSum
                        ]
                    )
                    mbIxSum
    in
        article
            [ classes
                [ T.f5
                , T.fw4
                , T.mt0
                , T.black
                ]
            ]
            (
            [ span
                []
                [ text <| depthStatus depth ]
            ]
            ++ sumDisplay
            )



bTreeUniformStatus : BTreeUniformType -> Html msg
bTreeUniformStatus bTreeUniformType =
    let
        depth = BTreeUniformType.depth bTreeUniformType
        mbIntFlex = BTreeUniformType.sumInt bTreeUniformType
    in
        treeStatus depth mbIntFlex


bTreeVariedStatus : BTreeVariedType -> Html msg
bTreeVariedStatus (BTreeVaried bTree) =
    let
        depth = BTree.depth bTree
        mbMbsSum = Nothing
    in
        treeStatus depth mbMbsSum


bTreeUniformLegend : BTreeUniformType -> Maybe (Html msg)
bTreeUniformLegend bTreeUniformType =
    case bTreeUniformType of
        BTreeInt _ ->
            Just bTreeIntCardLegend

        BTreeBigInt _ ->
            Just bTreeBigIntCardLegend

        BTreeString _ ->
            Nothing

        BTreeBool _ ->
            Nothing

        BTreeMusicNotePlayer _ _ ->
            Nothing

        BTreeNothing _ ->
            Nothing


bTreeBigIntCardLegend : Html msg
bTreeBigIntCardLegend =
    bTreeIntCardLegend


bTreeIntCardLegend : Html msg
bTreeIntCardLegend =
    article
        [ classes
            [ T.i
            , T.b
            , T.tc
            , T.center
            , T.f5
            , T.pa1
            ]
        ]
        [ span
            [ classes
                [T.black
                ]
            ]
            [ text "Legend: " ]
        , span
            [ classes
                [intNodeEvenColor
                ]
            ]
            [ text "Even " ]
        , span
            [ classes
                [intNodeOddColor
                ]
            ]
            [ text "Odd" ]
        ]


bTreeVariedLegend : BTreeVariedType -> Maybe (Html msg)
bTreeVariedLegend bTreeVariedType =
    if BTreeVariedType.hasAnyIntNodes bTreeVariedType
        then Just bTreeIntCardLegend
        else Nothing


viewTreeCard : String -> Html msg -> Maybe (Html msg) -> Maybe String -> Html msg -> Html msg
viewTreeCard title status mbLegend mbBgColor diagram =
    let
        articleTachyons =
            [ T.fl
            , T.w_100
            , T.w_20_ns
            , T.br2
            , T.ba
            , T.b__black_10
            , T.mw6
            , T.center
            , T.overflow_x_scroll
            ]  ++ (Maybe.Extra.unwrap [] List.singleton mbBgColor)
    in
        article
            [ classes articleTachyons ]
            [ div
                [ classes
                    [ T.tc
                    ]
                ]
                [ Html.h1
                    [ classes
                        [ T.f4
                        , T.mb2
                        , T.pt1
                        , T.black
                        ]
                    ]
                    [ text title ]
                , status
                , article
                    [ classes
                        [ T.mt0
                        , T.pl2
                        ]
                    ]
                    [ diagram ]
                , article
                    [ classes
                        [ T.center
                        ]
                    ]
                    [ Maybe.withDefault (span[][]) mbLegend ]
                ]
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

        RequestRandomInts direction ->
            let
                randomInts : Int -> Random.Generator (List Int)
                randomInts length =
                    Random.list length (Random.int 1 maxRandomInt)

                generatorInts : Random.Generator (List Int)
                generatorInts =
                    Random.andThen randomInts generatorRandomListLength
            in
                { model
                | directionForRandom = direction
                } ! [Random.generate ReceiveRandomInts generatorInts]

        RequestRandomPairsIntDirection ->
            let
                randomPairsIntDirection : Int -> Random.Generator (List (Int, Direction))
                randomPairsIntDirection length =
                    let
                        fn = \bool -> case bool of
                            True -> Right
                            False -> Left
                    in
                        Random.list length <| Random.pair (Random.int 1 maxRandomInt) (Random.map fn Random.bool)

                generatorPairsIntDirection : Random.Generator (List (Int, Direction))
                generatorPairsIntDirection =
                    Random.andThen randomPairsIntDirection generatorRandomListLength
            in
                model ! [Random.generate ReceiveRandomPairsIntDirection generatorPairsIntDirection]

        RequestRandomDelta ->
            model ! [Random.generate ReceiveRandomDelta (Random.int 1 100)]

        ReceiveRandomInts list ->
            let
                intTree = list
                    |> List.map toMaybeSafeInt
                    |> BTree.fromListAsIsBy  model.directionForRandom
                    |> BTree.map IntNodeVal
                    |> BTreeInt

                bigIntTree = list
                    |> List.map BigInt.fromInt
                    |> BTree.fromListAsIsBy model.directionForRandom
                    |> BTree.map BigIntNodeVal
                    |> BTreeBigInt
            in
                { model
                | intTree = intTree
                , bigIntTree = bigIntTree
                } ! []

        ReceiveRandomPairsIntDirection list ->
            let
                fn = \transformFn (int, direction) -> (transformFn int, direction)

                intTree = list
                    |> List.map (fn toMaybeSafeInt)
                    |> BTree.fromListAsIs_directed
                    |> BTree.map IntNodeVal
                    |> BTreeInt

                bigIntTree = list
                    |> List.map (fn BigInt.fromInt)
                    |> BTree.fromListAsIs_directed
                    |> BTree.map BigIntNodeVal
                    |> BTreeBigInt
            in
                { model
                | intTree = intTree
                , bigIntTree = bigIntTree
                } ! []

        ReceiveRandomDelta i ->
            { model | delta = i } ! []

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


generatorRandomListLength : Random.Generator Int
generatorRandomListLength =
    Random.int minRandomListLength maxRandomListLength


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


main =
  Html.programWithFlags -- using programWithFlags to get the seed values from JS
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
