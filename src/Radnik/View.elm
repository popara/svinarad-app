module Radnik.View exposing (view)

import Html exposing (div, text, Html, h1, a)
import Html.Attributes exposing (href)

import Radnik.Messages exposing (Msg)
import Radnik.Model exposing (Model)

import Job

view: Model -> Html Msg
view model =
  let errordiv = case model.err of
    Just txt -> div [] [text "Erooor"]
    Nothing -> div [] []
  in
    div []
    [ h1 [] [ text "Svi Na Rad" ]
    , errordiv
    , jobsview  model
    ]


jobsview: Model -> Html Msg
jobsview model =
  if List.isEmpty model.jobs
  then div [] [text "Ucitava se"]
  else div [] (List.map Job.view model.jobs)
