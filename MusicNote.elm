module MusicNote exposing (MusicNote(..), sortOrder, mbSortOrder, (:+:), (:-:), displayString)

import Array.Hamt as Array exposing (..)
import List.Extra exposing (elemIndex)


type MusicNote
    = A
    | A_sharp
    | B
    | C
    | C_sharp
    | D
    | D_sharp
    | E
    | F
    | F_sharp
    | G
    | G_sharp


notes : List MusicNote
notes =
    [ A
    , A_sharp
    , B
    , C
    , C_sharp
    , D
    , D_sharp
    , E
    , F
    , F_sharp
    , G
    , G_sharp
    ]


maxNoteIndex : Int
maxNoteIndex =
    (Array.length (Array.fromList notes)) - 1


minNoteIndex : Int
minNoteIndex =
    0


sortOrder : MusicNote -> String
sortOrder note =
    Basics.toString note


mbSortOrder : Maybe MusicNote -> String
mbSortOrder mbNote =
    case mbNote of
        Just note ->
            "Just " ++ (sortOrder note)

        Nothing ->
            "Nothing"


(:+:) : Maybe MusicNote -> Int -> Maybe MusicNote
(:+:) mbNote delta =
    let
        calcShiftedIndex: Int -> Maybe Int
        calcShiftedIndex index =
            let
                newIndex = index + (abs delta)
            in
                if newIndex <= maxNoteIndex
                    then Just newIndex
                    else Nothing
    in
        shift calcShiftedIndex mbNote


(:-:) : Maybe MusicNote -> Int -> Maybe MusicNote
(:-:) mbNote delta =
    let
        calcShiftedIndex: Int -> Maybe Int
        calcShiftedIndex index =
            let
                newIndex = index - (abs delta)
            in
                if newIndex >= minNoteIndex
                    then Just newIndex
                    else Nothing
    in
        shift calcShiftedIndex mbNote


shift : (Int -> Maybe Int) -> Maybe MusicNote -> Maybe MusicNote
shift calcShiftedIndex mbNote =
    mbNote
        |> Maybe.andThen (\note -> elemIndex note notes)
        |> Maybe.andThen calcShiftedIndex
        |> Maybe.andThen (\index -> Array.get index (Array.fromList notes))


displayString : MusicNote -> String
displayString note =
    case note of
        A ->
            "A"

        A_sharp ->
            "A#"

        B ->
            "B"

        C ->
            "C"

        C_sharp ->
            "C#"

        D ->
            "D"

        D_sharp ->
            "D#"

        E ->
            "E"

        F ->
            "F"

        F_sharp ->
            "F#"

        G ->
            "G"

        G_sharp ->
            "G#"