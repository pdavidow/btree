module TreeMusicPlayer exposing (treeMusicPlay)

import Maybe.Extra exposing (values)
import Time exposing (Time, millisecond, inSeconds, inMilliseconds)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree, flatten)
import MusicNote exposing (MusicNote, Freq(..), toFrequency)
import AudioNote exposing (AudioNote)
import Ports exposing (port_playNote)


noteDuration : Time
noteDuration = 500 * millisecond


gapDuration : Time
gapDuration = 100 * millisecond


interval : Time
interval = noteDuration + gapDuration


treeMusicPlay : BTreeUniformType -> Cmd msg
treeMusicPlay bTreeUniformType =
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
        notes = audioNotesFor freqs
        cmds = List.map port_playNote notes
    in
        Cmd.batch cmds


audioNotesFor : List Freq -> List AudioNote
audioNotesFor freqs =
    let
        lastIndex = (List.length freqs) - 1

        func: Int -> Freq -> AudioNote
        func index (Freq freq) =
            let
                startOffset =  (toFloat index) * interval

                stopOffset =  startOffset + noteDuration

                onEnded = if index == lastIndex
                    then Just True
                    else Nothing
            in
                AudioNote
                    freq
                    (inSeconds startOffset)
                    (inSeconds stopOffset)
                    onEnded
    in
        List.indexedMap func freqs