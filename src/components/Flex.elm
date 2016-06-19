module Flex exposing (row, column)

import Html exposing (Attribute, div, Html)
import Html.Attributes exposing (class)

rowClass : Attribute a
rowClass = class "row"

columnClass : Attribute a
columnClass = class "column"


row : List (Attribute a) -> List (Html a) -> Html a
row attrs html =
  div (rowClass :: attrs) html

column : List (Attribute a) -> List (Html a) -> Html a
column attrs html =
  div (columnClass :: attrs) html
