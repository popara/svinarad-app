module Job exposing (view)

import Html exposing (div, h1, text, Html)
import Html.Attributes exposing (class)

type alias WorkedId = String

type JobStatus
  = Fresh
  | Drafting
  | Drafted WorkedId
  | Working
  | WorkDone
  | PaymentDone
  | Canceled

type alias Model =
  { title: String
  , description: String
  , status: JobStatus
  , employer: String
  , worker: String
  , done: Int
  , value: Float
  }

view: Html a
view =
  div [ class "job-item" ]
  [ h1 [] [ text "Naslov posla" ]
  , div [ class "details" ]
    [ text "Detailji posla, kada gde"]

  , div [ class "parties" ]
    [ div [ class "poslodavac" ]
      []
    , div [ class "radnik" ]
      []
    ]
  ]
