-- Module to declare the app internal messages


module Msgs exposing (..)

import Models exposing (Issue)


type Msg
    = NoOp
    | InputOwner String
    | InputRepository String
    | Search
    | ToggleFavorite Issue
    | ToggleSorter
