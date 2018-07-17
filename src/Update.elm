-- Module to control the models update calls


module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Issue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        InputOwner inputText ->
            ( { model | owner = inputText }, Cmd.none )

        InputRepository inputText ->
            ( { model | repo = inputText }, Cmd.none )

        Search ->
            ( model, Cmd.none )

        ToggleFavorite issue ->
            ( toggleFavorite model issue, Cmd.none )

        ToggleSorter ->
            ( toggleSorter model, Cmd.none )


toggleFavorite : Model -> Issue -> Model
toggleFavorite model issue =
    let
        pick currentIssue =
            if issue.id == currentIssue.id then
                { issue | isFavorite = not issue.isFavorite }
            else
                currentIssue

        updateIssueList =
            List.map pick model.issues
    in
        { model | issues = updateIssueList }


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
