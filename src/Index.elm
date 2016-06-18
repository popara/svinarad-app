module Index exposing (Model, view, update, Msg, init, main)

import Html exposing (div, text, Html, a)
import Html.Attributes exposing (href)
import Html.App as Html

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
  [ div [] [text "Svi na Rad"]
  , a [ href "/Radnik.html" ] [ text "Radnik"] 
  ]

-- SUBS

subscriptions: Model -> Sub msg
subscriptions model = Sub.none
