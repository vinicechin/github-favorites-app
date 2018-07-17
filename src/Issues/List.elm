module Issues.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, placeholder)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg(..))
import Models exposing (Issue, Label)


view : List Issue -> Html Msg
view issues =
    main_ []
        [ issuesSearcher
        , issuesList issues
        ]


issuesSearcher : Html Msg
issuesSearcher =
    div []
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


issuesList : List Issue -> Html Msg
issuesList issues =
    div [ class "p2" ]
        [ issuesHeader
        , div [] (List.map issueRow issues)
        ]


issuesHeader : Html Msg
issuesHeader =
    div [ class "row issues-header" ]
        [ div [ class "col-2 issue-icons" ] []
        , div [ class "col-6" ] [ text "Issue" ]
        , div [ class "col-4 assigne-column" ] [ text "Assignee" ]
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
        , div [ class "col-6 issue-data" ]
            [ text ((toString issue.id) ++ " - ")
            , text issue.name
            , div [] (List.map labelsRow issue.labels)
            ]
        , div [ class "col-4 assigne-column" ] [ text issue.assignee ]
        ]


starIcon : Bool -> Html Msg
starIcon isFavorite =
    span [ class "star" ]
        [ i (starIconAttributes isFavorite)
            []
        , i [ class "fa fa-star star-hover", style [ ( "color", "green" ) ] ]
            []
        ]


starIconAttributes : Bool -> List (Attribute msg)
starIconAttributes isFavorite =
    let
        starClass =
            if isFavorite then
                "fa fa-star star-default"
            else
                "fa fa-star-o star-default"

        starColor =
            if isFavorite then
                "green"
            else
                "black"
    in
        [ class starClass, style [ ( "color", starColor ) ] ]


labelsRow : Label -> Html Msg
labelsRow label =
    span [ class "issue-label" ] [ text label.name ]
