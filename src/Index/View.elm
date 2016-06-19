module Index.View exposing (view)
import Index.Model exposing (Model)
import Index.Messages exposing (Msg)

import Html exposing (div, text, Html, a, img, h1, br)
import Html.Attributes exposing (href, src, class)

-- VIEW

view: Model -> Html Msg
view model =  div [ class "home-page" ]
  [ div [ class "moto" ]
    [ img [ (src "/img/svinarad-logo-text-white.svg"), (class "logo") ] []
    , h1 []
      [ text "Samo tako ovaj"
      , br [] []
      , text "svet može biti bolji!"
      ]
    ]
  , div [ class "actions" ]
    [ a
      [ href "/Radnik.html"
      , class "action-link"
      ] [ text "Želim da radim!" ]
    , a
      [ href "/Radnik.html"
      , class "action-link"
      ] [ text "Želim da uposlim nekog" ]
    ]
  ]
