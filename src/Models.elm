-- Module to declare the available app models


module Models exposing (..)

import RemoteData exposing (WebData)


type Route
    = IssuesRoute
    | FavoritesRoute
    | NotFoundRoute


type alias Model =
    { issues : WebData (List Issue)
    , sorter : String
    , owner : String
    , repo : String
    , route : Route
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


initialModel : Route -> Model
initialModel route =
    { issues = RemoteData.NotAsked
    , sorter = "id"
    , owner = ""
    , repo = ""
    , route = route
    }
