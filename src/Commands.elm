module Commands exposing (..)

import Http
import Json.Decode as Decode exposing (string, int, list, null, nullable, maybe, field, at, oneOf, decodeString)
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional, custom, hardcoded)
import Msgs exposing (Msg)
import Models exposing (Issue, Label, Assignee)
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
        |> hardcoded False
        |> required "state" string
        |> required "labels" (list labelDecoder)
        |> required "url" string
        |> optional "assignee" assigneeDecoder (Assignee "" "" "")


labelDecoder : Decode.Decoder Label
labelDecoder =
    decode Label
        |> required "name" string
        |> required "color" string


assigneeDecoder : Decode.Decoder Assignee
assigneeDecoder =
    decode Assignee
        |> required "login" string
        |> required "avatar_url" string
        |> required "html_url" string
