module Issues.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Issue, Label)


view : List Issue -> Html Msg
view issues =
    div []
        [ issuesList issues
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
    div [ class "row issue-container" ]
        [ div [ class "col-2 issue-icons" ]
            [ i [ class "fa fa-star" ] []
            , i [ class "fa fa-exclamation" ] []
            ]
        , div [ class "col-6" ]
            [ text issue.name
            , div [] (List.map labelsRow issue.labels)
            ]
        , div [ class "col-4 assigne-column" ] [ text issue.assignee ]
        ]


labelsRow : Label -> Html Msg
labelsRow label =
    span [ class "issue-label" ] [ text label.name ]
