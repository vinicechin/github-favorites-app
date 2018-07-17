-- Module to control the models update calls


module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Issue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Change inputText ->
            ( model, Cmd.none )

        Search ->
            ( model, Cmd.none )

        ToggleFavorite issue ->
            ( updateIssue model issue, Cmd.none )


updateIssue : Model -> Issue -> Model
updateIssue model issue =
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
