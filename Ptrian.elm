module Ptrian exposing (Ptrian, ptrian, toNormalString)


import List.Extra exposing (getAt, last)

type alias Ptrian = List (List Int)


ptrian : Int -> Ptrian
ptrian depth =
    -- one based

    let
        f : Int -> Ptrian -> Ptrian
        f level acc =
            let
                rowlen = level -- equilateral

                formula : Int -> Int
                formula k = 
                    if k == 1 || k == rowlen then
                        1
                    else
                        let
                            priorRow = Maybe.withDefault [] <| last acc

                            upLeft = Maybe.withDefault 0 <| getAt (k - 2) priorRow
                            upTop  = Maybe.withDefault 0 <| getAt (k - 1) priorRow
                        in
                            upLeft + upTop

                row = List.map formula (List.range 1 rowlen)
            in
                acc ++ [row]
    in
        List.foldl f [] (List.range 1 depth)


toNormalString : Ptrian -> String
toNormalString x =         
    x
        |> List.concat
        |> List.map toString
        |> String.join " "
    
