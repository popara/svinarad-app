module Radnik.Update exposing (update)

import Radnik.Messages exposing (Msg)
import Radnik.Model exposing (Model)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = model ! []
