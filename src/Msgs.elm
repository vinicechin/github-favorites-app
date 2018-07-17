-- Module to declare the app internal messages


module Msgs exposing (..)

import Models exposing (Issue)


type Msg
    = NoOp
    | Change String
    | Search
    | ToggleFavorite Issue
