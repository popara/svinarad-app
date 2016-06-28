module Main exposing (main)

import Index.Model exposing (Model, init)
import Index.View exposing (view)
import Index.Update exposing (update)

import Html.App as Html

main: Program Never
main = Html.program
  { init = init
  , update = update
  , view  = view
  , subscriptions = subscriptions
  }


-- SUBS

subscriptions: Model -> Sub msg
subscriptions model = Sub.none
