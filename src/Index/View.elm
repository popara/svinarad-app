module Index.View exposing (view)
import Index.Model exposing (Model)
import Index.Messages exposing (Msg)

import Html exposing (div, text, Html, a, img)
import Html.Attributes exposing (href, src)

import Job

-- VIEW

view: Model -> Html Msg
view model =  div []
  [ img [ src "/img/svinarad-logo.svg" ] []
  , a [ href "/Radnik.html" ] [ text "Radnik"]
  , Job.view 
  , div [] [text "Svi na Rad"]
  ]
