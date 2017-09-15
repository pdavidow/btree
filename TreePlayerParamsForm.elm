module TreePlayerParamsForm exposing (..)

import Html exposing (Html, div, span, form, text, input, label, legend, button)
import Html.Attributes as A exposing (attribute, classList)
import Html.Events exposing (onClick)
import Form exposing (Form)
import Form.Validate exposing (..)
import Form.Input
import Set exposing (Set)

import Main exposing (Model, Msg(..))
import TreePlayerParams exposing (TreePlayerParams)


musicTreeParamsFormValidation : Validation () TreePlayerParams
musicTreeParamsFormValidation =
    Form.Validate.succeed TreePlayerParams


--viewMusicNoteTreeParamsForm : Model -> Html Msg
--viewMusicNoteTreeParamsForm model =
--    Html.map FormMsg (musicNoteTreeParamsForm model.musicTreeParamsForm)


musicNoteTreeParamsForm : Form () TreePlayerParams -> Html Form.Msg
musicNoteTreeParamsForm form =
    let
        traversalOrderOptions = ["PreOrder", "InOrder", "PostOrder"]

        disableSubmit =
            Set.isEmpty <| Form.getChangedFields form

        submitBtnAttributes =
            [ onClick Form.Submit
            , classList
                [ ( "btn btn-primary", True )
                , ( "disabled", disableSubmit )
                ]
            ]
                ++ if disableSubmit then
                    [ attribute "disabled" "true" ]
                   else
                    []
    in
        div
            [ --class "form-horizontal"
            --, style [ ( "margin", "50px auto" ), ( "width", "600px" ) ]
            ]
            [ legend [] [ text "Player Settings" ]
            , radioGroup traversalOrderOptions
                (text "Traversal Order")
                (Form.getFieldAsString "traversalOrder" form)
            , formActions
                [ button submitBtnAttributes
                    [ text "Submit" ]
                , text " "
                , button
                    [ onClick (Form.Reset initialFields)
                    , class "btn btn-default"
                    ]
                    [ text "Reset" ]
                ]
            ]
