-- Main view of the app


module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model)
import Issues.List


view : Model -> Html Msg
view model =
    div []
        [ mainHeader
        , page model
        ]


mainHeader : Html Msg
mainHeader =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "App Header" ] ]


page : Model -> Html Msg
page model =
    Issues.List.view model
