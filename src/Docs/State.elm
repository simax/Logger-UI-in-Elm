module Docs.State exposing (..)

import Http
import Task
import Docs.Types exposing (..)


initModel : Model
initModel =
    { content = "" }


fetchContent : String -> Cmd Msg
fetchContent url =
    let
        task =
            Http.getString url

        cmd =
            Task.perform Fail Documentation task
    in
        cmd


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Documentation content ->
            ( { model | content = content }, Cmd.none )

        Fail error ->
            ( { model | content = (toString error) }, Cmd.none )

        Content contentType ->
            case contentType of
                DocsHome ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/home.md" )

                DotNetClient ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/dot_net/client.md" )

                DotNetExample ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/dot_net/examples.md" )

                ClassicAspClient ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/classic_asp/client.md" )

                ClassicAspExample ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/classic_asp/examples.md" )

                JavascriptClient ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/javascript/client.md" )

                JavascriptExample ->
                    ( model, fetchContent "http://localhost:8080/static/markdown/javascript/examples.md" )
