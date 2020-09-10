module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, string)


-- Main


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- Model


type alias Model =
  { state : State
  , task : Maybe Task 
  , tasks : Maybe (List Task)
  }

type State
  = Failure String
  | Loading
  | Success String

type alias Task =
  { i : String
  , title : String
  , createdAt : String
  , done : Bool
  }

intial : Model
intial =
  { state = Loading
  , task = Nothing 
  , tasks = Nothing
  }



-- Init


init : () -> (Model, Cmd Msg)
init _ =
  ( intial
  , Cmd.none
  )


-- Update


type Msg
  = RequestList
  | RequestTask
  | GotList (Result Http.Error String)
  | GotTask (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
  _ ->
    (model, Cmd.none)


-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- View


title : String
title = "Testing"


view : Model -> Html Msg
view model =
  div []
  [ h2 [] [ text "Testing"]
  ]