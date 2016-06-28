module Firebase.Auth exposing (signup)

import Http
import Task exposing (Task)

signup: String -> String -> Task Http.Error String
signup email password =
  Http.getString "foobar"
