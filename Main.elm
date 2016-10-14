module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href)
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
            --"http://ekmlogger.ekmpowershop.com"
            "http://localhost:49851/logs"
            --"http://localhost:9000/logs"

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
  { error : Maybe String
  , logs : List Log
  }


initModel : Model
initModel =
    { error = Nothing
    , logs = []
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, fetchLogs )


type Msg
    = Logs Response
    | Fail Http.Error


-- update
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Logs response ->
            ( { model | logs = response }, Cmd.none )

        Fail error ->
            ( { model | error = Just (toString error) }, Cmd.none )

-- view
view : Model -> Html Msg
view model =
    case model.error of
        Nothing ->
          logsView
            model.logs
        _ ->
          div [] [
            div
              []
              [ text (Maybe.withDefault "" model.error) ]
          ]

tableItem : Log -> Html msg
tableItem log =
    tr []
            [ td [ class "collapsing" ]
                [ text log.created_at ]
            , td [ class "center aligned collapsing" ]
                [ i [ class "green spy icon" ]
                    []
                ]
            , td [ class "collapsing" ]
                [ text log.application ]
            , td [ class "center aligned collapsing" ]
                [ button [ class "ui mini blue label" ]
                    [ text "sqlite" ]
                , button [ class "ui mini blue label" ]
                    [ text "query" ]
                ]
            , td []
                [ text log.message ]
            , td [ class "collapsing" ]
                [ a [ class "ui mini primary button", href "#/logs/5800e3e2edad930d286ec7b5" ]
                    [ text "Details" ]
                ]
            ]


logsView : List Log -> Html msg
logsView logs =
    table [ class "ui celled striped table" ]
        [ thead []
            [ tr []
                [ th [ class "collapsing" ]
                    [ text "Logged At" ]
                , th [ class "collapsing" ]
                    [ text "Level" ]
                , th [ class "collapsing" ]
                    [ text "Application" ]
                , th [ class "collapsing" ]
                    [ text "Tags" ]
                , th []
                    [ text "Message" ]
                , th [ class "collapsing" ]
                    []
                , text "      "
                ]
            ]
            , tbody []
                (List.map (\l -> tableItem l) logs)
        ]

-- subscriptions
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
