module MusicNote exposing (MusicNote(..), Freq(..), sorter, mbSorter, (:+:), (:-:), displayString, toFrequency)

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


type Freq = Freq Float


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


sorter : MusicNote -> String
sorter note =
    Basics.toString note


mbSorter : Maybe MusicNote -> String
mbSorter mbNote =
    case mbNote of
        Just note ->
            "Just " ++ (sorter note)

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


toFrequency : MusicNote -> Freq
toFrequency note =
    -- http://newt.phys.unsw.edu.au/jw/notes.html
    case note of
        A -> -- A3
            Freq 220.00

        A_sharp ->
            Freq 233.08

        B ->
            Freq 246.94

        C -> -- C4 (Middle C)
            Freq 261.63

        C_sharp ->
            Freq 277.18

        D ->
            Freq 293.67

        D_sharp ->
            Freq 311.13

        E ->
            Freq 329.63

        F ->
            Freq 349.23

        F_sharp ->
            Freq 369.99

        G ->
            Freq 392.00

        G_sharp ->
            Freq 415.30
