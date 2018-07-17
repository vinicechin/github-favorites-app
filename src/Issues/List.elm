module Issues.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, placeholder, title, href, target, src)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg(..))
import Models exposing (Model, Issue, Label)


-- Issues list view


view : Model -> Html Msg
view model =
    let
        sorter =
            model.sorter
    in
        main_ []
            [ issuesSearcher
            , issuesSorter sorter
            , issuesList model.issues sorter
            ]



-- Issues searcher


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



-- Issues list sorter


issuesSorter : String -> Html Msg
issuesSorter sorter =
    let
        idColor =
            if sorter == "id" then
                "#bbbbbb"
            else
                "white"

        stateColor =
            if sorter == "state" then
                "#bbbbbb"
            else
                "white"
    in
        div [ class "issues-sorter" ]
            [ text "Id"
            , div [ class "issues-sorter-btn id-sorter", style [ ( "background-color", idColor ) ] ]
                []
            , div [ class "issues-sorter-btn state-sorter", style [ ( "background-color", stateColor ) ] ]
                []
            , text "State"
            ]



-- Issues list items displayer


issuesList : List Issue -> String -> Html Msg
issuesList issues sorter =
    div [ class "p2" ]
        [ issuesHeader
        , div [] (List.map issueRow (sortIssuesList issues sorter))
        ]



-- Sort issues list based on sorter selected


sortIssuesList : List Issue -> String -> List Issue
sortIssuesList issues sorter =
    if sorter == "id" then
        List.sortBy .id issues
    else if sorter == "state" then
        List.sortBy .state issues
    else
        List.sortBy .id issues



-- Issues list header


issuesHeader : Html Msg
issuesHeader =
    div [ class "row issues-header" ]
        [ div [ class "col-2 issue-icons" ] []
        , div [ class "col-6" ] [ text "Issue" ]
        , div [ class "col-4 assigne-column" ] [ text "Assignee" ]
        ]



-- Issues list item


issueRow : Issue -> Html Msg
issueRow issue =
    div
        [ class "row issue-container" ]
        [ div [ class "col-2 issue-icons" ]
            [ starIcon issue
            , stateIcon issue.state
            ]
        , div [ class "col-6 issue-data" ]
            [ text ((toString issue.id) ++ " - ")
            , a [ href issue.url, target "_blank" ] [ text issue.name ]
            , div [] (List.map labelsRow issue.labels)
            ]
        , div [ class "col-4 assigne-column" ]
            [ a
                [ href issue.assigneeUrl
                , target "_blank"
                ]
                [ img
                    [ src issue.assigneeImageUrl
                    , title issue.assignee
                    , class "assignee-img"
                    ]
                    []
                ]
            ]
        ]



-- Display star icon used to add or remove issue from favorites


starIcon : Issue -> Html Msg
starIcon issue =
    span [ class "star", onClick (ToggleFavorite issue) ]
        [ i (starIconAttributes issue.isFavorite)
            []
        , i [ class "fa fa-star star-hover", style [ ( "color", "#e2c151" ) ] ]
            []
        ]



-- Set star icon attributes depending if issue is favorited or not


starIconAttributes : Bool -> List (Attribute msg)
starIconAttributes isFavorite =
    let
        starClass =
            if isFavorite then
                "fa fa-star star-default"
            else
                "fa fa-star-o star-default"
    in
        [ class starClass, style [ ( "color", "#e2c151" ) ] ]



-- Indicates issue state


stateIcon : String -> Html Msg
stateIcon state =
    let
        stateItem =
            if state == "open" then
                { color = "green", title = "Open" }
            else
                { color = "red", title = "Closed" }
    in
        i
            [ class "fa fa-exclamation"
            , style [ ( "color", stateItem.color ) ]
            , title stateItem.title
            ]
            []



-- Display issue labels


labelsRow : Label -> Html Msg
labelsRow label =
    span
        [ class "issue-label"
        , style [ ( "background-color", label.color ) ]
        ]
        [ text label.name ]
