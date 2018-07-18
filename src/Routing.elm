module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map IssuesRoute top
        , map IssuesRoute (s "issues")
        , map FavoritesRoute (s "favorites")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Nothing ->
            NotFoundRoute

        Just route ->
            route


issuesPath : String
issuesPath =
    "#issues"


favoritesPath : String
favoritesPath =
    "#favorites"
