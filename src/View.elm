-- Main view of the app


module View exposing (..)

import Html exposing (Html, Attribute, div, text, a)
import Html.Attributes exposing (class, style, value, href)
import Msgs exposing (Msg)
import Models exposing (Model, Route)
import Issues.List
import RemoteData
import Json.Decode as Decode
import Routing exposing (issuesPath, favoritesPath)


view : Model -> Html Msg
view model =
    div []
        [ mainHeader model.route
        , page model
        ]


mainHeader : Route -> Html Msg
mainHeader route =
    let
        colors =
            case route of
                Models.IssuesRoute ->
                    { issues = "#2222bb", favorites = "white" }

                Models.FavoritesRoute ->
                    { issues = "white", favorites = "#2222bb" }

                Models.NotFoundRoute ->
                    { issues = "white", favorites = "white" }
    in
        div [ class "clearfix mb2 white bg-black" ]
            [ div [ class "left", style [ ( "color", "#e2c151" ) ] ] [ text "Github Favorites" ]
            , div [ class "left" ]
                [ div []
                    [ a
                        [ class "app-nav-btn"
                        , style [ ( "color", colors.issues ) ]
                        , href issuesPath
                        ]
                        [ text "Issues" ]
                    ]
                ]
            , div [ class "left" ]
                [ div []
                    [ a
                        [ class "app-nav-btn"
                        , style [ ( "color", colors.favorites ) ]
                        , href favoritesPath
                        ]
                        [ text "Favorites" ]
                    ]
                ]
            ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.IssuesRoute ->
            Issues.List.view model

        Models.FavoritesRoute ->
            Issues.List.view model

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found" ]
