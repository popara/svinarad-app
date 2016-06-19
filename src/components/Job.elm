module Job exposing (foo, view)

import Html exposing (div, h1, text, Html)


foo: Int
foo = 5

view: Html a
view =
  div []
  [ h1 [] [ text "Sexi" ]
  ]
