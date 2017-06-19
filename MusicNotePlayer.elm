module MusicNotePlayer exposing (playTreeMusic)

import Maybe.Extra exposing (values)
import Time exposing (Time, millisecond, inSeconds, inMilliseconds)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree, flatten)
import MusicNote exposing (MusicNote, toFrequency)
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
                freqs : List Float
                freqs = flatten bTree
                    |> values
                    |> List.map toFrequency
            in
                playFreqs freqs

        _ ->
            Cmd.none


playFreqs : List Float -> Cmd msg
playFreqs freqs =
    let
        totalInterval = interval * toFloat (List.length freqs)
        onDoneCmd = port_announceOnDonePlayNotes (inMilliseconds totalInterval) -- todo: use onEnd in AudioNode
        playCmds = playFreqsCmds freqs
    in
        playCmds
            |> List.reverse -- todo report issue
            |> (::) onDoneCmd
            |> Cmd.batch


playFreqsCmds : List Float -> List (Cmd msg)
playFreqsCmds freqs =
    let
        notes = audioNotesFor freqs
    in
        List.map port_playNote notes


audioNotesFor : List Float -> List AudioNote
audioNotesFor freqs =
    let
        func: Int -> Float -> AudioNote
        func index freq =
            let
                startOffset =  (toFloat index) * interval
                stopOffset =  startOffset + noteDuration
            in
                AudioNote freq (inSeconds startOffset) (inSeconds stopOffset)
    in
        List.indexedMap func freqs