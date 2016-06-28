module Radnik.View exposing (view)

import Html exposing (div, text, Html, h1, a)
import Html.Attributes exposing (href)

import Radnik.Messages exposing (Msg)
import Radnik.Model exposing (Model)

import Job

view: Model -> Html Msg
view model =  div []
  [ h1 [] [ text "Svi Na Rad" ]
  , Job.view
  ]
