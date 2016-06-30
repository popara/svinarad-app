module Radnik.Messages exposing (Msg(..))
import Http
type Msg
  = Noop
  | Jobs (List String)
  | Error Http.Error 
