module Radnik.Signup exposing (Model, view, update, Msg)
import Firebase.Auth exposing (signup)
import Html exposing (div, text, Html)

type alias Model =
  { credentials: Credentials
  , personal: PersonalInfo
  , social: SocialInfo
  }

type alias Email = String
type alias Password = String

type alias Credentials =
  { email: Email
  , password: Password
  , passwordagain: Password
  }

type alias PersonalInfo =
  { name: String
  , dateofbirth: String
  }

type alias SocialInfo =
  { twitter: String
  , facebook: String
  , phoneno: String
  }

type Msg
 = Noop


update: Msg -> Model -> (Model, Cmd Msg)

update msg model = model ! []

-- VIEW

view: Model -> Html Msg

view model =  div [] [text "Signup"]
