module TestsHelper exposing (musicNotePlayerOnNothing, uniformNothingSingelton, uniformNothing3Nodes, toIntVariety, toBigIntVariety, toStringVariety, toBoolVariety, toMusicNoteVariety)

import BigInt exposing (BigInt)

import BTreeUniformType exposing (BTreeUniformType(..))
import BTree exposing (BTree(..), fromListBy, singleton)
import NodeTag exposing (NodeVariety(..), IntNode(..), BigIntNode(..), StringNode(..), BoolNode(..), MusicNoteNode(..), NothingNode(..))
import MusicNotePlayer exposing (MusicNotePlayer(..))
import MaybeSafe exposing (MaybeSafe)


musicNotePlayerOnNothing : MusicNotePlayer
musicNotePlayerOnNothing =
   MusicNotePlayer
       { mbNote = Nothing
       , isPlaying = False
       , mbId = Nothing
       }


uniformNothingSingelton : BTreeUniformType
uniformNothingSingelton =
    BTreeNothing <| singleton <| NothingNodeVal


uniformNothing3Nodes : BTreeUniformType
uniformNothing3Nodes =
    BTreeNothing <| fromListBy Basics.toString  <| List.repeat 3 NothingNodeVal


toIntVariety : MaybeSafe Int -> NodeVariety
toIntVariety val =
    IntVariety <| IntNodeVal <| val


toBigIntVariety : BigInt -> NodeVariety
toBigIntVariety val =
    BigIntVariety <| BigIntNodeVal <| val   


toStringVariety : String -> NodeVariety
toStringVariety val =
    StringVariety <| StringNodeVal <| val


toBoolVariety : Maybe Bool -> NodeVariety
toBoolVariety val =
    BoolVariety <| BoolNodeVal <| val


toMusicNoteVariety : MusicNotePlayer -> NodeVariety
toMusicNoteVariety val =
    MusicNoteVariety <| MusicNoteNodeVal <| val
