-- Module to declare the app internal messages


module Msgs exposing (..)

import Models exposing (Issue)
import RemoteData exposing (WebData)


type Msg
    = InputOwner String
    | InputRepository String
    | Search
    | ToggleFavorite Issue
    | ToggleSorter
    | OnFetchIssues (WebData (List Issue))
