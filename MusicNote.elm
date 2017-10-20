module MusicNote exposing (MusicNote(..), Freq(..), MidiNumber(..), sorter, mbSorter, (:+:), (:-:), displayString, toFreq, minMidiNumber, maxMidiNumber)

-- http://newt.phys.unsw.edu.au/jw/notes.html

import List.Extra exposing (last)
import Maybe.Extra exposing (unwrap)
import EveryDict exposing (EveryDict, fromList)

type MidiNumber = MidiNumber Int
type MusicNote = MusicNote MidiNumber
type Freq = Freq Float


notesList : List (MidiNumber, {name : String, freq : Freq})
notesList =
    [ (MidiNumber 21, {name = "A0",  freq = Freq 27.500})
    , (MidiNumber 22, {name = "A0#", freq =            Freq 29.135})
    , (MidiNumber 23, {name = "B0",  freq = Freq 30.868})
    , (MidiNumber 24, {name = "C1",  freq = Freq 32.703})
    , (MidiNumber 25, {name = "C1#", freq =            Freq 34.648})
    , (MidiNumber 26, {name = "D1",  freq = Freq 36.708})
    , (MidiNumber 27, {name = "D1#", freq =            Freq 38.891})
    , (MidiNumber 28, {name = "E1",  freq = Freq 41.203})
    , (MidiNumber 29, {name = "F1",  freq = Freq 43.654})
    , (MidiNumber 30, {name = "F1#", freq =            Freq 46.249})
    , (MidiNumber 31, {name = "G1",  freq = Freq 48.999})
    , (MidiNumber 32, {name = "G1#", freq =            Freq 51.913})
    , (MidiNumber 33, {name = "A1",  freq = Freq 55.000})
    , (MidiNumber 34, {name = "A1#", freq =            Freq 58.270})
    , (MidiNumber 35, {name = "B1",  freq = Freq 61.735})
    , (MidiNumber 36, {name = "C2",  freq = Freq 65.406})
    , (MidiNumber 37, {name = "C2#", freq =            Freq 69.296})
    , (MidiNumber 38, {name = "D2",  freq = Freq 73.416})
    , (MidiNumber 39, {name = "D2#", freq =            Freq 77.782})
    , (MidiNumber 40, {name = "E2",  freq = Freq 82.407})
    , (MidiNumber 41, {name = "F2",  freq = Freq 87.307})
    , (MidiNumber 42, {name = "F2#", freq =            Freq 92.499})
    , (MidiNumber 43, {name = "G2",  freq = Freq 97.999})
    , (MidiNumber 44, {name = "G2#", freq =            Freq 103.83})
    , (MidiNumber 45, {name = "A2",  freq = Freq 110.00})
    , (MidiNumber 46, {name = "A2#", freq =            Freq 116.54})
    , (MidiNumber 47, {name = "B2",  freq = Freq 123.47})
    , (MidiNumber 48, {name = "C3",  freq = Freq 130.81})
    , (MidiNumber 49, {name = "C3#", freq =            Freq 138.59})
    , (MidiNumber 50, {name = "D3",  freq = Freq 146.83})
    , (MidiNumber 51, {name = "D3#", freq =            Freq 155.56})
    , (MidiNumber 52, {name = "E3",  freq = Freq 164.81})
    , (MidiNumber 53, {name = "F3",  freq = Freq 174.61})
    , (MidiNumber 54, {name = "F3#", freq =            Freq 185.00})
    , (MidiNumber 55, {name = "G3",  freq = Freq 196.00})
    , (MidiNumber 56, {name = "G3#", freq =            Freq 207.65})
    , (MidiNumber 57, {name = "A3",  freq = Freq 220.00})
    , (MidiNumber 58, {name = "A3#", freq =            Freq 233.08})
    , (MidiNumber 59, {name = "B3",  freq = Freq 246.94})
    , (MidiNumber 60, {name = "C4",  freq = Freq 261.63}) ------------- Middle C
    , (MidiNumber 61, {name = "C4#", freq =            Freq 277.18})
    , (MidiNumber 62, {name = "D4",  freq = Freq 293.67})
    , (MidiNumber 63, {name = "D4#", freq =            Freq 311.13})
    , (MidiNumber 64, {name = "E4",  freq = Freq 329.63})
    , (MidiNumber 65, {name = "F4",  freq = Freq 349.23})
    , (MidiNumber 66, {name = "F4#", freq =            Freq 369.99})
    , (MidiNumber 67, {name = "G4",  freq = Freq 392.00})
    , (MidiNumber 68, {name = "G4#", freq =            Freq 415.30})
    , (MidiNumber 69, {name = "A4",  freq = Freq 440.00})
    , (MidiNumber 70, {name = "A4#", freq =            Freq 466.16})
    , (MidiNumber 71, {name = "B4",  freq = Freq 493.88})
    , (MidiNumber 72, {name = "C5",  freq = Freq 523.25})
    , (MidiNumber 73, {name = "C5#", freq =            Freq 554.37})
    , (MidiNumber 74, {name = "D5",  freq = Freq 587.33})
    , (MidiNumber 75, {name = "D5#", freq =            Freq 622.25})
    , (MidiNumber 76, {name = "E5",  freq = Freq 659.26})
    , (MidiNumber 77, {name = "F5",  freq = Freq 698.46})
    , (MidiNumber 78, {name = "F5#", freq =            Freq 739.99})
    , (MidiNumber 79, {name = "G5",  freq = Freq 783.99})
    , (MidiNumber 80, {name = "G5#", freq =            Freq 830.61})
    , (MidiNumber 81, {name = "A5",  freq = Freq 880.00})
    , (MidiNumber 82, {name = "A5#", freq =            Freq 932.33})
    , (MidiNumber 83, {name = "B5",  freq = Freq 987.77})
    , (MidiNumber 84, {name = "C6",  freq = Freq 1046.5})
    , (MidiNumber 85, {name = "C6#", freq =            Freq 1108.7})
    , (MidiNumber 86, {name = "D6",  freq = Freq 1174.7})
    , (MidiNumber 87, {name = "D6#", freq =            Freq 1244.5})
    , (MidiNumber 88, {name = "E6",  freq = Freq 1318.5})
    , (MidiNumber 89, {name = "F6",  freq = Freq 1396.9})
    , (MidiNumber 90, {name = "F6#", freq =            Freq 1480.0})
    , (MidiNumber 91, {name = "G6",  freq = Freq 1568.0})
    , (MidiNumber 92, {name = "G6#", freq =            Freq 1661.2})
    , (MidiNumber 93, {name = "A6",  freq = Freq 1760.0})
    , (MidiNumber 94, {name = "A6#", freq =            Freq 1864.7})
    , (MidiNumber 95, {name = "B6",  freq = Freq 1975.5})
    , (MidiNumber 96, {name = "C7",  freq = Freq 2093.0})
    , (MidiNumber 97, {name = "C7#", freq =            Freq 2217.5})
    , (MidiNumber 98, {name = "D7",  freq = Freq 2349.3})
    , (MidiNumber 99, {name = "D7#", freq =            Freq 2489.0})
    , (MidiNumber 100,{name = "E7",  freq = Freq 2637.0})
    , (MidiNumber 101,{name = "F7",  freq = Freq 2793.0})
    , (MidiNumber 102,{name = "F7#", freq =            Freq 2960.0})
    , (MidiNumber 103,{name = "G7",  freq = Freq 3136.0})
    , (MidiNumber 104,{name = "G7#", freq =            Freq 3322.4})
    , (MidiNumber 105,{name = "A7",  freq = Freq 3520.0})
    , (MidiNumber 106,{name = "A7#", freq =            Freq 3729.3})
    , (MidiNumber 107,{name = "B7",  freq = Freq 3951.1})
    , (MidiNumber 108,{name = "C8",  freq = Freq 4186.0})
    ]


notesDict : EveryDict MidiNumber {name : String, freq : Freq}
notesDict =
    EveryDict.fromList notesList


minMidiNumber : MidiNumber
minMidiNumber =
    Tuple.first <| Maybe.withDefault (MidiNumber 0, {freq = Freq 0.0, name = ""}) <| List.head notesList


maxMidiNumber : MidiNumber
maxMidiNumber =
    Tuple.first <| Maybe.withDefault (MidiNumber 0, {freq = Freq 0.0, name = ""}) <| List.Extra.last notesList


sorter : MusicNote -> Int
sorter (MusicNote (MidiNumber i)) =
    i


mbSorter : Maybe MusicNote -> Int
mbSorter mbNote =
    Maybe.Extra.unwrap 0 sorter mbNote


isMidiNumberWithinRange : MidiNumber -> Bool
isMidiNumberWithinRange (MidiNumber i) =
    let
        (MidiNumber min) = minMidiNumber
        (MidiNumber max) = maxMidiNumber
    in
        (i >= min) && (i <= max)


(:+:) : Maybe MusicNote -> Int -> Maybe MusicNote
(:+:) mbNote delta =
    case mbNote of
        Just (MusicNote (MidiNumber i)) ->
            let
                result = MidiNumber <| i + delta
            in
                if (isMidiNumberWithinRange result) then Just (MusicNote result)
                else Nothing

        Nothing ->
            Nothing


(:-:) : Maybe MusicNote -> Int -> Maybe MusicNote
(:-:) mbNote delta =
    (:+:) mbNote (negate delta)


displayString : MusicNote -> Maybe String
displayString (MusicNote midiNumber) =
    EveryDict.get midiNumber notesDict
        |> Maybe.map .name


toFreq : MusicNote -> Maybe Freq
toFreq (MusicNote midiNumber) =
    EveryDict.get midiNumber notesDict
        |> Maybe.map .freq
