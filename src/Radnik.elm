module Radnik exposing (Model, view, update, Msg, init, main)

import Html exposing (div, text, Html, h1, a)
import Html.App as Html
import Html.Attributes exposing (href)

main: Program Never
main = Html.program
  { init = init
  , update = update
  , view  = view
  , subscriptions = subscriptions
  }


type alias Model =
  {
  }

type Msg
 = Noop

init: (Model, Cmd Msg)
init = {} ! []

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = model ! []

-- VIEW

view: Model -> Html Msg
view model =  div []
  [ h1 [] [ text "Svi Na Rad" ]
  , a [ href "/" ] [ text "Start" ]
  ]

-- SUBS

subscriptions: Model -> Sub msg
subscriptions model = Sub.none
