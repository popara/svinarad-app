module Index.Update exposing (..)
import Index.Model exposing (Model)
import Index.Messages exposing (Msg)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model = model ! []
