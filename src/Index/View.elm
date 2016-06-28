module Index.View exposing (view)
import Index.Model exposing (Model)
import Index.Messages exposing (Msg)

import Html exposing (div, text, Html, a, img, h1, br, strong, h2, p)
import Html.Attributes exposing (href, src, class)

-- VIEW

view: Model -> Html Msg
view model =
  div [ class "home-page" ]
  [ hero
  , info
  ]


hero: Html Msg
hero =
  div [ class "hero" ]
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
      [ href "/radnik.html"
      , class "action-link"
      ] [ text "Želim da radim!" ]
    , a
      [ href "/poslodavac.html"
      , class "action-link"
      ] [ text "Želim da uposlim nekog" ]
    ]
  ]

info: Html Msg
info =
  div [ class "info" ]
    [ h2 []
      [ text "Šta je ovo?"]
    , p []
      [ text "Osnovna ideja aplikacije je da pronađe "
      , strong []
        [ text "privremeni" ]
      , text " posao ljudima. Da im da moć da zarade novac svojim trudom."
      ]
    ]
