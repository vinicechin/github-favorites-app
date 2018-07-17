-- Module to declare the available app models


module Models exposing (..)


initialModel : Model
initialModel =
    { issues = [ Issue 0 "Teste Issue" False True [ Label "label 1" "yellow" ] ]
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
    , isFavorite : Bool
    , isOpen : Bool
    , labels : List Label
    }


type alias Label =
    { name : String
    , color : String
    }
