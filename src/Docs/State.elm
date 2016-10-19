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
            let
                _ =
                    Debug.log "content" content
            in
                ( { model | content = content }, Cmd.none )

        Fail error ->
            ( { model | content = (toString error) }, Cmd.none )

        Content contentType ->
            case contentType of
                DotNetClient ->
                    let
                        url =
                            "http://localhost:8080/static/markdown/dot_net/client.md"

                        _ =
                            Debug.log "fetchContent" url
                    in
                        ( model, fetchContent url )

                DotNetExample ->
                    ( model, fetchContent "" )

                ClassicAspClient ->
                    ( model, fetchContent "" )

                ClassicAspExample ->
                    ( model, fetchContent "" )

                JavascriptClient ->
                    ( model, fetchContent "" )

                JavascriptExample ->
                    ( model, fetchContent "" )
