-- Module to declare the available app models


module Models exposing (..)

import RemoteData exposing (WebData)


initialModel : Model
initialModel =
    { issues = RemoteData.NotAsked

    --[ Issue
    --    0
    --    "Teste Issue"
    --    "vinicechin"
    --    "https://avatars1.githubusercontent.com/u/16272285?v=4"
    --    "https://github.com/vinicechin"
    --    False
    --    "open"
    --    [ Label "label 1" "yellow", Label "label 2" "#e2c151" ]
    --    "https://github.com/vinicechin/angular-test/issues/1"
    --, Issue
    --    1
    --    "Teste Issue 2 muito extensa para testar"
    --    "fulanocomnomecomprido"
    --    "https://avatars1.githubusercontent.com/u/16272285?v=4"
    --    "https://github.com/vinicechin"
    --    True
    --    "closed"
    --    [ Label "label 2" "#e2c151" ]
    --    "https://github.com/vinicechin/angular-test/issues/2"
    --]
    , sorter = "id"
    , owner = ""
    , repo = ""
    }


type alias Model =
    { issues : WebData (List Issue)
    , sorter : String
    , owner : String
    , repo : String
    }


type alias Issue =
    { id : Int
    , name : String
    , isFavorite : Bool
    , state : String
    , labels : List Label
    , url : String
    , assignee : Assignee
    }


type alias Assignee =
    { login : String
    , avatar : String
    , url : String
    }


type alias Label =
    { name : String
    , color : String
    }
