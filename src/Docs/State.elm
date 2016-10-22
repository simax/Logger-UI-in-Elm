module Docs.State exposing (..)

import Http
import Task
import Docs.Types exposing (..)


host : String
host =
    "http://localhost:8080/"


initModel : Model
initModel =
    { content = "" }


getDoc : Maybe DocInfo -> Cmd Msg
getDoc docInfo =
    case docInfo of
        Just { docType, docHash, url } ->
            fetchContent url

        Nothing ->
            Cmd.none


fetchInitialContent : Cmd Msg
fetchInitialContent =
    documents
        |> List.head
        |> getDoc


fetchContent : String -> Cmd Msg
fetchContent url =
    Http.getString (host ++ url)
        |> Task.perform Fail SetDocumentContent


getDocumentationByType : DocType -> Cmd Msg
getDocumentationByType docType =
    List.filter (\doc -> doc.docType == docType) documents
        |> List.head
        |> getDoc


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fail error ->
            ( { model | content = (toString error) }, Cmd.none )

        SetDocumentContent content ->
            ( { model | content = content }, Cmd.none )

        Content docType ->
            let
                _ =
                    Debug.log "DocType:" docType
            in
                ( model, (getDocumentationByType docType) )
