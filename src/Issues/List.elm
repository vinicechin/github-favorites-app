module Issues.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, placeholder, title, href, target, src)
import Html.Events exposing (onInput, onClick)
import Http exposing (Error(..))
import Msgs exposing (Msg(..))
import Models exposing (Model, Issue, Label)
import RemoteData exposing (WebData)


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
            , onInput InputOwner
            , class "searchInput"
            ]
            []
        , input
            [ placeholder "Repository"
            , onInput InputRepository
            , class "searchInput"
            ]
            []
        , button [ class "searchBtn", onClick Search ] [ text "Search" ]
        ]



-- Issues list sorter


issuesSorter : String -> Html Msg
issuesSorter sorter =
    let
        colors =
            if sorter == "id" then
                { id = "#bbbbbb", state = "white" }
            else if sorter == "state" then
                { id = "white", state = "#bbbbbb" }
            else
                { id = "#bbbbbb", state = "white" }
    in
        div [ class "issues-sorter" ]
            [ boldText (sorter == "id") "Id"
            , div
                [ class "issues-sorter-btn id-sorter"
                , style [ ( "background-color", colors.id ) ]
                , onClick ToggleSorter
                ]
                []
            , div
                [ class "issues-sorter-btn state-sorter"
                , style [ ( "background-color", colors.state ) ]
                , onClick ToggleSorter
                ]
                []
            , boldText (sorter == "state") "State"
            ]



-- Set text bold based on passed boolean


boldText : Bool -> String -> Html Msg
boldText setBold sorterLabel =
    if setBold then
        b [ class "issues-sorter-label" ] [ text sorterLabel ]
    else
        span [ class "issues-sorter-label" ] [ text sorterLabel ]



-- Issues list items displayer


issuesList : WebData (List Issue) -> String -> Html Msg
issuesList response sorter =
    div [ class "p2" ]
        [ issuesHeader
        , div [] (maybeList response sorter)
        ]



-- Handle each possible state of the returned issues list data


maybeList : WebData (List Issue) -> String -> List (Html Msg)
maybeList response sorter =
    case response of
        RemoteData.NotAsked ->
            [ text "" ]

        RemoteData.Loading ->
            [ text "Loading..." ]

        RemoteData.Success issues ->
            (List.map issueRow (sortIssuesList issues sorter))

        RemoteData.Failure error ->
            case error of
                BadUrl urlText ->
                    [ text ("Bad Url: " ++ urlText) ]

                Timeout ->
                    [ text ("Http Timeout") ]

                NetworkError ->
                    [ text ("Network Error") ]

                BadStatus response ->
                    [ text ("Bad Http Status: " ++ toString response.status.code) ]

                BadPayload message response ->
                    [ text
                        ("Bad Http Payload: "
                            ++ toString message
                            ++ " ("
                            ++ toString response.status.code
                            ++ ")"
                        )
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
        , assigneeInfo issue
        ]



-- Assignee avatar and links


assigneeInfo : Issue -> Html Msg
assigneeInfo issue =
    if (not (issue.assignee.login == "")) then
        div
            [ class "col-4 assigne-column" ]
            [ a
                [ href issue.assignee.url
                , target "_blank"
                ]
                [ img
                    [ src issue.assignee.avatar
                    , title issue.assignee.login
                    , class "assignee-img"
                    ]
                    []
                ]
            ]
    else
        div
            [ class "col-4 assignee-empty" ]
            []



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
        , style [ ( "background-color", "#" ++ label.color ) ]
        ]
        [ text label.name ]
