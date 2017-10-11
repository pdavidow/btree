module MusicNote exposing (MusicNote(..), Freq(..), MidiNumber, sorter, mbSorter, (:+:), (:-:), displayString, toFreq)

-- http://newt.phys.unsw.edu.au/jw/notes.html

import List.Extra exposing (last)
import Maybe.Extra exposing (unwrap)
import Dict exposing (Dict, fromList)

type alias MidiNumber = Int
type MusicNote = MusicNote MidiNumber
type Freq = Freq Float


notesList : List (MidiNumber, {name : String, freq : Freq})
notesList =
    [ (21, {name = "A0",  freq = Freq 27.500})
    , (22, {name = "A0#", freq =            Freq 29.135})
    , (23, {name = "B0",  freq = Freq 30.868})
    , (24, {name = "C1",  freq = Freq 32.703})
    , (25, {name = "C1#", freq =            Freq 34.648})
    , (26, {name = "D1",  freq = Freq 36.708})
    , (27, {name = "D1#", freq =            Freq 38.891})
    , (28, {name = "E1",  freq = Freq 41.203})
    , (29, {name = "F1",  freq = Freq 43.654})
    , (30, {name = "F1#", freq =            Freq 46.249})
    , (31, {name = "G1",  freq = Freq 48.999})
    , (32, {name = "G1#", freq =            Freq 51.913})
    , (33, {name = "A1",  freq = Freq 55.000})
    , (34, {name = "A1#", freq =            Freq 58.270})
    , (35, {name = "B1",  freq = Freq 61.735})
    , (36, {name = "C2",  freq = Freq 65.406})
    , (37, {name = "C2#", freq =            Freq 69.296})
    , (38, {name = "D2",  freq = Freq 73.416})
    , (39, {name = "D2#", freq =            Freq 77.782})
    , (40, {name = "E2",  freq = Freq 82.407})
    , (41, {name = "F2",  freq = Freq 87.307})
    , (42, {name = "F2#", freq =            Freq 92.499})
    , (43, {name = "G2",  freq = Freq 97.999})
    , (44, {name = "G2#", freq =            Freq 103.83})
    , (45, {name = "A2",  freq = Freq 110.00})
    , (46, {name = "A2#", freq =            Freq 116.54})
    , (47, {name = "B2",  freq = Freq 123.47})
    , (48, {name = "C3",  freq = Freq 130.81})
    , (49, {name = "C3#", freq =            Freq 138.59})
    , (50, {name = "D3",  freq = Freq 146.83})
    , (51, {name = "D3#", freq =            Freq 155.56})
    , (52, {name = "E3",  freq = Freq 164.81})
    , (53, {name = "F3",  freq = Freq 174.61})
    , (54, {name = "F3#", freq =            Freq 185.00})
    , (55, {name = "G3",  freq = Freq 196.00})
    , (56, {name = "G3#", freq =            Freq 207.65})
    , (57, {name = "A3",  freq = Freq 220.00})
    , (58, {name = "A3#", freq =            Freq 233.08})
    , (59, {name = "B3",  freq = Freq 246.94})
    , (60, {name = "C4",  freq = Freq 261.63}) ------------- Middle C
    , (61, {name = "C4#", freq =            Freq 277.18})
    , (62, {name = "D4",  freq = Freq 293.67})
    , (63, {name = "D4#", freq =            Freq 311.13})
    , (64, {name = "E4",  freq = Freq 329.63})
    , (65, {name = "F4",  freq = Freq 349.23})
    , (66, {name = "F4#", freq =            Freq 369.99})
    , (67, {name = "G4",  freq = Freq 392.00})
    , (68, {name = "G4#", freq =            Freq 415.30})
    , (69, {name = "A4",  freq = Freq 440.00})
    , (70, {name = "A4#", freq =            Freq 466.16})
    , (71, {name = "B4",  freq = Freq 493.88})
    , (72, {name = "C5",  freq = Freq 523.25})
    , (73, {name = "C5#", freq =            Freq 554.37})
    , (74, {name = "D5",  freq = Freq 587.33})
    , (75, {name = "D5#", freq =            Freq 622.25})
    , (76, {name = "E5",  freq = Freq 659.26})
    , (77, {name = "F5",  freq = Freq 698.46})
    , (78, {name = "F5#", freq =            Freq 739.99})
    , (79, {name = "G5",  freq = Freq 783.99})
    , (80, {name = "G5#", freq =            Freq 830.61})
    , (81, {name = "A5",  freq = Freq 880.00})
    , (82, {name = "A5#", freq =            Freq 932.33})
    , (83, {name = "B5",  freq = Freq 987.77})
    , (84, {name = "C6",  freq = Freq 1046.5})
    , (85, {name = "C6#", freq =            Freq 1108.7})
    , (86, {name = "D6",  freq = Freq 1174.7})
    , (87, {name = "D6#", freq =            Freq 1244.5})
    , (88, {name = "E6",  freq = Freq 1318.5})
    , (89, {name = "F6",  freq = Freq 1396.9})
    , (90, {name = "F6#", freq =            Freq 1480.0})
    , (91, {name = "G6",  freq = Freq 1568.0})
    , (92, {name = "G6#", freq =            Freq 1661.2})
    , (93, {name = "A6",  freq = Freq 1760.0})
    , (94, {name = "A6#", freq =            Freq 1864.7})
    , (95, {name = "B6",  freq = Freq 1975.5})
    , (96, {name = "C7",  freq = Freq 2093.0})
    , (97, {name = "C7#", freq =            Freq 2217.5})
    , (98, {name = "D7",  freq = Freq 2349.3})
    , (99, {name = "D7#", freq =            Freq 2489.0})
    , (100,{name = "E7",  freq = Freq 2637.0})
    , (101,{name = "F7",  freq = Freq 2793.0})
    , (102,{name = "F7#", freq =            Freq 2960.0})
    , (103,{name = "G7",  freq = Freq 3136.0})
    , (104,{name = "G7#", freq =            Freq 3322.4})
    , (105,{name = "A7",  freq = Freq 3520.0})
    , (106,{name = "A7#", freq =            Freq 3729.3})
    , (107,{name = "B7",  freq = Freq 3951.1})
    , (108,{name = "C8",  freq = Freq 4186.0})
    ]


notesDict : Dict MidiNumber {name : String, freq : Freq}
notesDict =
    Dict.fromList notesList


minMidiNumber : MidiNumber
minMidiNumber =
    Tuple.first <| Maybe.withDefault (0, {freq = Freq 0.0, name = ""}) <| List.head notesList


maxMidiNumber : MidiNumber
maxMidiNumber =
    Tuple.first <| Maybe.withDefault (0, {freq = Freq 0.0, name = ""}) <| List.Extra.last notesList


sorter : MusicNote -> MidiNumber
sorter (MusicNote midiNumber) =
    midiNumber


mbSorter : Maybe MusicNote -> MidiNumber
mbSorter mbNote =
    Maybe.Extra.unwrap 0 sorter mbNote


isMidiNumberWithinRange : MidiNumber -> Bool
isMidiNumberWithinRange n =
    (n >= minMidiNumber) && (n <= maxMidiNumber)


(:+:) : Maybe MusicNote -> Int -> Maybe MusicNote
(:+:) mbNote delta =
    case mbNote of
        Just (MusicNote midiNumber) ->
            let
                result = midiNumber + delta
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
    Dict.get midiNumber notesDict
        |> Maybe.map .name


toFreq : MusicNote -> Maybe Freq
toFreq (MusicNote midiNumber) =
    Dict.get midiNumber notesDict
        |> Maybe.map .freq
