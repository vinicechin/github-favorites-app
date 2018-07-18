-- Module to control the models update calls


module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Issue)
import Commands exposing (fetchIssues)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputOwner inputText ->
            ( { model | owner = inputText }, Cmd.none )

        InputRepository inputText ->
            ( { model | repo = inputText }, Cmd.none )

        Search ->
            ( model, fetchIssues model.owner model.repo )

        ToggleFavorite issue ->
            ( toggleFavorite model issue, Cmd.none )

        ToggleSorter ->
            ( toggleSorter model, Cmd.none )

        OnFetchIssues response ->
            ( { model | issues = response }, Cmd.none )


toggleFavorite : Model -> Issue -> Model
toggleFavorite model issue =
    let
        pick currentIssue =
            if issue.id == currentIssue.id then
                { issue | isFavorite = not issue.isFavorite }
            else
                currentIssue

        updateIssueList issues =
            List.map pick issues

        updateIssues =
            RemoteData.map updateIssueList model.issues
    in
        { model | issues = updateIssues }


toggleSorter : Model -> Model
toggleSorter model =
    let
        newSorter =
            if model.sorter == "id" then
                "state"
            else if model.sorter == "state" then
                "id"
            else
                "id"
    in
        { model | sorter = newSorter }
