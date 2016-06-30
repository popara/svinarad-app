module Radnik.Model exposing (Model, init)
import Radnik.Messages exposing (Msg(..))
import Http
import Task
import Json.Decode as Json exposing ((:=))



getJobs: Cmd Msg
getJobs =
  let t = Http.get jobdecode "https://svinarad.firebaseio.com/jobs.json?orderByChild=status&equalsTo=open"
  in Task.perform (\_-> Noop) Jobs t

jobdecode: Json.Decoder (List String)
jobdecode =
  let s = Json.keyValuePairs ("title" := Json.string)
  in Json.map (List.map snd) s 

type alias Model =
  { jobs: List String
  , err: Maybe String
  }

init: (Model, Cmd Msg)
init = { jobs = [], err = Nothing } ! [getJobs]
