module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)
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


-- Init


intial : Model
intial =
  { state = Loading
  , task = Nothing 
  , tasks = Nothing
  }

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
    RequestTask ->
      (model, getTask 1)

    GotTask result ->
      case result of
        Ok str ->
          ({ model | state = Success str}, Cmd.none)

        Err _ ->
          (model, Cmd.none)

    _ ->
      (model, Cmd.none)


-- Http


getTask : Int -> Cmd Msg
getTask id =
  Http.get
    { url = ("-u luke:stephen -i http://localhost:5000/todo/api/v1/tasks/" ++ (fromInt id))
    , expect = Http.expectJson GotTask decodeTitle
    }

decodeTitle : Decoder String
decodeTitle =
  field "task" (field "title" string)


-- View


title : String
title = "Testing"


view : Model -> Html Msg
view model =
  case model.state of
    Success str ->
      div []
        [ h2 [] [ text str]
        ]

    _ ->
      div []
        [ h2 [] [ text "Testing" ]
        , button [ onClick RequestTask ] [ text "get task" ]
        ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


