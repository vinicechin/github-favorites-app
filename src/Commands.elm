module Commands exposing (..)

import Http
import Json.Decode as Decode exposing (string, int, list, nullable, at)
import Json.Decode.Pipeline exposing (decode, required, custom, hardcoded)
import Msgs exposing (Msg)
import Models exposing (Issue, Label)
import RemoteData


fetchIssues : Cmd Msg
fetchIssues =
    Http.get fetchIssuesUrl issuesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchIssues


fetchIssuesUrl : String
fetchIssuesUrl =
    "https://api.github.com/repos/vinicechin/angular-test/issues"


issuesDecoder : Decode.Decoder (List Issue)
issuesDecoder =
    list issueDecoder


issueDecoder : Decode.Decoder Issue
issueDecoder =
    decode Issue
        |> required "number" int
        |> required "title" string
        |> hardcoded "vinicechin"
        |> hardcoded "https://avatars1.githubusercontent.com/u/16272285?v=4"
        |> hardcoded "https://github.com/vinicechin"
        --|> custom (at [ "assignee", "login" ] (nullable string))
        --|> custom (at [ "assignee", "avatar_url" ] (nullable string))
        --|> custom (at [ "assignee", "html_url" ] (nullable string))
        |> hardcoded False
        |> required "state" string
        --|> custom (at [ "labels" ] (nullable (list labelDecoder)))
        |> hardcoded [ Label "label 1" "yellow", Label "label 2" "#e2c151" ]
        |> required "url" string


labelDecoder : Decode.Decoder Label
labelDecoder =
    decode Label
        |> required "name" string
        |> required "color" string
