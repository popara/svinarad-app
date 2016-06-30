module Radnik.Update exposing (update)

import Radnik.Messages exposing (Msg(..))
import Radnik.Model exposing (Model)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = case msg of
  Jobs jbs -> { model | jobs = jbs } ! []
  Error err ->
    let _ = Debug.log "err" err 
    in { model | err = Just "err" } ! []
  _ -> model ! []
