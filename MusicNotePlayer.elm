port module MusicNotePlayer exposing (playTreeMusicNote)

import Maybe.Extra exposing (values)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree, flatten)
import MusicNote exposing (MusicNote, toFrequency)


playTreeMusicNote : BTreeUniformType -> Cmd msg
playTreeMusicNote bTreeUniformType =
    case bTreeUniformType of
        BTreeMusicNote bTree ->
            let
                freqs : List Float
                freqs = flatten bTree
                    |> values
                    |> List.map toFrequency
            in
                port_playFreqs (Debug.log "elm freqs" freqs)

        _ ->
            Cmd.none


port port_playFreqs : List Float -> Cmd msg


