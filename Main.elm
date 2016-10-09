module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Http
import Task
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)


type alias Response =
    List Log


responseDecoder : Decoder (List Log)
responseDecoder =
    list logDecoder



-- responseDecoder : Decoder Response
-- responseDecoder =
--     object3 Response
--         ("id" := int)
--         ("joke" := string)
--         ("categories" := list string)
--         |> at [ "value" ]


logDecoder : Decoder Log
logDecoder =
    decode Log
        |> required "id" string
        |> required "application" string
        |> required "level" string
        |> required "message" string
        |> optional "tags" (list string) []
        |> required "created_at" string


fetchLogs : Cmd Msg
fetchLogs =
    let
        url =
            "http://localhost:9000/logs"

        task =
            -- Http.getString url
            Http.get responseDecoder url

        cmd =
            Task.perform Fail Logs task
    in
        cmd



-- model


type alias Log =
    { id : String
    , application : String
    , level : String
    , message : String
    , tags : List String
    , created_at : String
    }


type alias Model =
    List Log


initModel : Model
initModel =
    []


init : ( Model, Cmd Msg )
init =
    ( initModel, fetchLogs )



-- update


type Msg
    = Logs Response
    | Fail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Logs response ->
            ( response, Cmd.none )

        Fail error ->
            ( [], Cmd.none )



-- view


view : Model -> Html Msg
view model =
    case model of
        [] ->
            div [] [ text "No logs exist." ]

        _ ->
            ul []
                (List.map listItem model)


listItem : Log -> Html msg
listItem l =
    li [] [ span [] [ text (toString l) ] ]



-- subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
