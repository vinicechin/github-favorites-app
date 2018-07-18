-- Main view of the app


module View exposing (..)

import Html exposing (Html, Attribute, div, text, a)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (Model)
import Issues.List
import Issues.Favorites
import RemoteData
import Json.Decode as Decode
import Routing exposing (issuesPath, favoritesPath)


view : Model -> Html Msg
view model =
    div []
        [ mainHeader
        , page model
        ]


mainHeader : Html Msg
mainHeader =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ div []
                [ a
                    [ class "btn regular app-nav-btn"
                    , href issuesPath
                    ]
                    [ text "Issues" ]
                ]
            ]
        , div [ class "left p2" ]
            [ div []
                [ a
                    [ class "btn regular app-nav-btn"
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
            Issues.Favorites.view model

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not Found" ]
