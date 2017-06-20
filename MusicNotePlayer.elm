module MusicNotePlayer exposing (playTreeMusic)

import Maybe.Extra exposing (values)
import Time exposing (Time, millisecond, inSeconds, inMilliseconds)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree, flatten)
import MusicNote exposing (MusicNote, Freq(..), toFrequency)
import AudioNote exposing (AudioNote)
import Ports exposing (port_playNote, port_announceOnDonePlayNotes)


noteDuration : Time
noteDuration = 500 * millisecond


gapDuration : Time
gapDuration = 100 * millisecond


interval : Time
interval = noteDuration + gapDuration


playTreeMusic : BTreeUniformType -> Cmd msg
playTreeMusic bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNote bTree ->
            let
                freqs = flatten bTree
                    |> values
                    |> List.map toFrequency
            in
                playFreqs freqs

        _ ->
            Cmd.none


playFreqs : List Freq -> Cmd msg
playFreqs freqs =
    let
        totalInterval = interval * toFloat (List.length freqs)
        onDoneCmd = port_announceOnDonePlayNotes (inMilliseconds totalInterval) -- todo: use onEnd in AudioNode
        playCmds = playFreqsCmds freqs
    in
        onDoneCmd::playCmds
            |> Cmd.batch


playFreqsCmds : List Freq -> List (Cmd msg)
playFreqsCmds freqs =
    let
        notes = audioNotesFor freqs
    in
        List.map port_playNote notes


audioNotesFor : List Freq -> List AudioNote
audioNotesFor freqs =
    let
        func: Int -> Freq -> AudioNote
        func index (Freq freq) =
            let
                startOffset =  (toFloat index) * interval
                stopOffset =  startOffset + noteDuration
            in
                AudioNote freq (inSeconds startOffset) (inSeconds stopOffset)
    in
        List.indexedMap func freqs