module Issues.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, placeholder)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg(..))
import Models exposing (Issue, Label)


view : List Issue -> Html Msg
view issues =
    main_ []
        [ div []
            [ input
                [ placeholder "Owner"
                , onInput Change
                , class "searchInput"
                ]
                []
            , input
                [ placeholder "Repository"
                , onInput Change
                , class "searchInput"
                ]
                []
            , button [ class "searchBtn", onClick Search ] [ text "Search" ]
            ]
        , issuesList issues
        ]


issuesList : List Issue -> Html Msg
issuesList issues =
    div [ class "p2" ]
        [ div [ class "row" ]
            [ div [ class "col-2 issue-icons" ] []
            , div [ class "col-6" ] [ text "Issue" ]
            , div [ class "col-4 assigne-column" ] [ text "Assignee" ]
            ]
        , div [] (List.map issueRow issues)
        ]


issueRow : Issue -> Html Msg
issueRow issue =
    Debug.log (toString issue)
        div
        [ class "row issue-container" ]
        [ div [ class "col-2 issue-icons" ]
            [ starIcon issue.isFavorite
            , i [ class "fa fa-exclamation" ] []
            ]
        , div [ class "col-6" ]
            [ text ((toString issue.id) ++ " - ")
            , text issue.name
            , div [] (List.map labelsRow issue.labels)
            ]
        , div [ class "col-4 assigne-column" ] [ text issue.assignee ]
        ]


labelsRow : Label -> Html Msg
labelsRow label =
    span [ class "issue-label" ] [ text label.name ]


starIcon : Bool -> Html Msg
starIcon isFavorite =
    span [ class "star" ]
        [ i [ starClass isFavorite, starColor isFavorite ]
            []
        , i [ class "fa fa-star star-hover", style [ ( "color", "green" ) ] ]
            []
        ]


starClass : Bool -> Attribute msg
starClass isFavorite =
    if isFavorite then
        class "fa fa-star star-default"
    else
        class "fa fa-star-o star-default"


starColor : Bool -> Attribute msg
starColor isFavorite =
    if isFavorite then
        style [ ( "color", "green" ) ]
    else
        style [ ( "color", "black" ) ]
