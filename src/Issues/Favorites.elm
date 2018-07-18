module Issues.Favorites exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, placeholder, title, href, target, src)
import Html.Events exposing (onInput, onClick)
import Http exposing (Error(..))
import Msgs exposing (Msg(..))
import Models exposing (Model, Issue, Label)
import RemoteData exposing (WebData)


-- Issues list view


view : Model -> Html Msg
view model =
    main_ []
        []
