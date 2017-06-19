module MusicNote exposing (MusicNote(..), sortOrder, mbSortOrder, (:+:), (:-:), displayString, toFrequency)

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


-- todo: type alias Freq = Float


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


-- todo: Freq type alias
toFrequency : MusicNote -> Float
toFrequency note =
    -- http://newt.phys.unsw.edu.au/jw/notes.html
    case note of
        A -> -- A3
            220.00

        A_sharp ->
            233.08

        B ->
            246.94

        C -> -- C4 (Middle C)
            261.63

        C_sharp ->
            277.18

        D ->
            293.67

        D_sharp ->
            311.13

        E ->
            329.63

        F ->
            349.23

        F_sharp ->
            369.99

        G ->
            392.00

        G_sharp ->
            415.30
