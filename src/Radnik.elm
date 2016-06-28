module Radnik exposing (main)

import Html.App as Html
import Radnik.View exposing (view)
import Radnik.Model exposing (init, Model)
import Radnik.Update exposing (update)
import Radnik.Signup 


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
