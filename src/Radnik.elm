module Radnik exposing (Model, view, update, Msg, init)

import Html exposing (div, text, Html)

type alias Model =
  {
  }

type Msg
 = Noop

init: Model
init = {} 

update: Msg -> Model -> (Model, Cmd Msg)

update msg model = model ! []

-- VIEW

view: Model -> Html Msg

view model =  div [] [text "Radnik"]
