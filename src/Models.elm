-- Module to declare the available app models


module Models exposing (..)


initialModel : Model
initialModel =
    { issues =
        [ Issue 0 "Teste Issue" "vinicechin" False "Open" [ Label "label 1" "yellow", Label "label 2" "pink" ]
        , Issue 1 "Teste Issue 2 muito extensa para testar" "fulanocomnomecomprido" True "Closed" [ Label "label 2" "pink" ]
        ]
    , sorter = "id"
    , owner = ""
    , repo = ""
    }


type alias Model =
    { issues : List Issue
    , sorter : String
    , owner : String
    , repo : String
    }


type alias Issue =
    { id : Int
    , name : String
    , assignee : String
    , isFavorite : Bool
    , state : String
    , labels : List Label
    }


type alias Label =
    { name : String
    , color : String
    }
