module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (attribute, class, href, src, name, type', placeholder)
import Http
import Task
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Navigation exposing (..)
import String
import Docs.View
import Docs.Types
import Docs.State


serverAPI : String
serverAPI =
    "http://localhost:9000/logs"



--"http://localhost:9000/logs"
--"http://ekmlogger.ekmpowershop.com"
--"http://localhost:49851/logs"


type alias Response =
    List Log


responseDecoder : Decoder (List Log)
responseDecoder =
    list logDecoder


logDecoder : Decoder Log
logDecoder =
    decode Log
        |> required "id" string
        |> required "application" string
        |> required "level" string
        |> required "message" string
        |> optional "tags" (list string) []
        |> required "created_at" string


fetchLogs : String -> Cmd Msg
fetchLogs url =
    let
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
    { page : Page
    , error : Maybe String
    , logs : List Log
    , docs : Docs.Types.Model
    }


initModel : Page -> Model
initModel page =
    { page = page
    , error = Nothing
    , logs = []
    , docs = Docs.State.initModel
    }


init : Page -> ( Model, Cmd Msg )
init page =
    ( initModel page, (fetchLogs serverAPI) )


type Msg
    = Logs Response
    | Navigate Page
    | Fail Http.Error
    | DocsMsg Docs.Types.Msg


toHash : Page -> String
toHash page =
    case page of
        LogsMonitor ->
            "#"

        LogsList ->
            "#logs"

        Docs ->
            "#docs"

        NotFound ->
            "#notfound"



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Logs response ->
            ( { model | logs = response }, Cmd.none )

        Fail error ->
            ( { model | error = Just (toString error) }, Cmd.none )

        Navigate page ->
            ( model, newUrl (toHash page) )

        DocsMsg docsMsg ->
            let
                ( docModel, docMsg ) =
                    Docs.State.update docsMsg model.docs

                _ =
                    Debug.log "docModel:" (toString docModel)
            in
                ( { model | docs = docModel }, Cmd.none )



-- ( model, Cmd.none )
-- ( model, Cmd.none )
-- urlUpdate


urlUpdate : Page -> Model -> ( Model, Cmd Msg )
urlUpdate page model =
    ( { model | page = page }, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    case model.error of
        Nothing ->
            case model.page of
                LogsMonitor ->
                    div []
                        [ viewLogsList model ]

                LogsList ->
                    div []
                        [ viewLogsList model ]

                Docs ->
                    viewSiteWrapper
                        (div []
                            [ logViewPageHeader
                            , App.map DocsMsg (Docs.View.view model.docs)
                            ]
                        )

                NotFound ->
                    div []
                        [ logViewPageHeader
                        , viewNotFound
                        ]

        _ ->
            viewSiteWrapper
                (div
                    []
                    [ logViewPageHeader
                    , div [ class "ui middle message aligned center aligned grid error" ]
                        [ text <| "Houston, we have a problem: " ++ (Maybe.withDefault "" model.error) ++ " has occured." ]
                    , logViewFooter
                    ]
                )


viewDocs : Model -> Html Msg
viewDocs model =
    div
        []
        [ text "Documentation" ]


viewNotFound : Html Msg
viewNotFound =
    div [] [ text "Oops, we couldn't find what you were looking for" ]


viewLogsList : Model -> Html Msg
viewLogsList model =
    viewSiteWrapper
        (div
            []
            [ logViewPageHeader
            , logFilters
            , logsView
                model.logs
            , logViewFooter
            ]
        )


viewSiteWrapper : Html Msg -> Html Msg
viewSiteWrapper contents =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div []
                [ div
                    [ class "wrapper" ]
                    [ div [ class "site-wrapper", attribute "style" "height: 100vh;" ]
                        [ contents ]
                    ]
                ]
            ]
        ]


logViewFooter : Html Msg
logViewFooter =
    div [ class "ui center aligned container" ]
        [ div [ class "ui divider" ]
            []
        , footer []
            [ h4 [ class "ui header" ]
                [ text "EKM Systems Ltd" ]
            ]
        ]


logFilters : Html Msg
logFilters =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div []
                [ div [ class "ui segment" ]
                    [ div [ class "ui form" ]
                        [ div [ class "two fields" ]
                            [ div [ class "field" ]
                                [ div [ class "ui fluid search selection dropdown" ]
                                    [ input [ name "application", type' "hidden", Html.Attributes.value "" ]
                                        []
                                    , i [ class "dropdown icon" ]
                                        []
                                    , input [ class "search", attribute "tabindex" "0", type' "text" ]
                                        []
                                    , div [ class "text" ]
                                        [ text "All" ]
                                    , div [ class "menu", attribute "tabindex" "-1" ]
                                        [ div [ class "item active selected", attribute "data-value" "" ]
                                            [ text "All" ]
                                        , div [ class "item", attribute "data-value" "EKM Powershop" ]
                                            [ text "EKM Powershop" ]
                                        , div [ class "item", attribute "data-value" "Test App" ]
                                            [ text "Test App" ]
                                        ]
                                    ]
                                ]
                            , div [ class "field" ]
                                [ div [ class "ui fluid multiple search selection dropdown" ]
                                    [ input [ name "tags", type' "hidden", Html.Attributes.value "" ]
                                        []
                                    , i [ class "dropdown icon" ]
                                        []
                                    , input [ class "search", attribute "tabindex" "0", type' "text" ]
                                        []
                                    , span [ class "sizer" ]
                                        []
                                    , div [ class "default text" ]
                                        [ text "Tags" ]
                                    , div [ class "menu", attribute "tabindex" "-1" ]
                                        [ div [ class "item", attribute "data-value" "aaaa" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "aaaa"
                                            ]
                                        , div [ class "item", attribute "data-value" "bbbb" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "bbbb"
                                            ]
                                        , div [ class "item", attribute "data-value" "cccc" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "cccc"
                                            ]
                                        , div [ class "item", attribute "data-value" "dddd" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "dddd"
                                            ]
                                        , div [ class "item", attribute "data-value" "query" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "query"
                                            ]
                                        , div [ class "item", attribute "data-value" "request" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "request"
                                            ]
                                        , div [ class "item", attribute "data-value" "sqlite" ]
                                            [ i [ class "blue circle icon" ]
                                                []
                                            , text "sqlite"
                                            ]
                                        ]
                                    ]
                                ]
                            ]
                        , div [ class "inline fields" ]
                            [ div [ class "field" ]
                                [ div [ class "ui checkbox tooltip", attribute "data-content" "Trace" ]
                                    [ input [ name "level[1]", type' "checkbox", Html.Attributes.value "on" ]
                                        []
                                    , label []
                                        [ i [ class "green spy icon" ]
                                            []
                                        ]
                                    ]
                                ]
                            , div [ class "field" ]
                                [ div [ class "ui checkbox tooltip", attribute "data-content" "Debug" ]
                                    [ input [ name "level[2]", type' "checkbox", Html.Attributes.value "on" ]
                                        []
                                    , label []
                                        [ i [ class "blue spy icon" ]
                                            []
                                        ]
                                    ]
                                ]
                            , div [ class "field" ]
                                [ div [ class "ui checkbox tooltip", attribute "data-content" "Info" ]
                                    [ input [ name "level[3]", type' "checkbox", Html.Attributes.value "on" ]
                                        []
                                    , label []
                                        [ i [ class "blue info icon" ]
                                            []
                                        ]
                                    ]
                                ]
                            , div [ class "field" ]
                                [ div [ class "ui checkbox tooltip", attribute "data-content" "Warning" ]
                                    [ input [ name "level[4]", type' "checkbox", Html.Attributes.value "on" ]
                                        []
                                    , label []
                                        [ i [ class "orange warning icon" ]
                                            []
                                        ]
                                    ]
                                ]
                            , div [ class "field" ]
                                [ div [ class "ui checkbox tooltip", attribute "data-content" "Error" ]
                                    [ input [ name "level[5]", type' "checkbox", Html.Attributes.value "on" ]
                                        []
                                    , label []
                                        [ i [ class "red warning sign icon" ]
                                            []
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    , h4 [ class "header" ]
                        [ text "Meta" ]
                    , div [ class "ui form" ]
                        [ div [ class "two fields" ]
                            [ div [ class "field" ]
                                [ input [ name "metaKey", placeholder "Meta Key", type' "text", Html.Attributes.value "" ]
                                    []
                                ]
                            , div [ class "field" ]
                                [ input [ name "metaValue", placeholder "Meta Value", type' "text", Html.Attributes.value "" ]
                                    []
                                ]
                            , button [ class "ui positive circular icon button" ]
                                [ i [ class "plus icon" ]
                                    []
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


logViewPageHeader : Html Msg
logViewPageHeader =
    header [ class "ui top menu" ]
        [ div [ class "item" ]
            [ a [ onClick (Navigate LogsMonitor) ]
                [ img [ attribute "height" "26", src "../static/img/logo.svg" ]
                    []
                ]
            ]
        , a [ class "item", onClick (Navigate LogsMonitor) ]
            [ text "Monitor" ]
        , a [ class "item", onClick (Navigate LogsList) ]
            [ text "Logs" ]
        , a [ class "item", onClick (Navigate Docs) ]
            [ text "Docs" ]
        , div [ class "borderless right menu" ]
            [ div [ class "ui dropdown item", attribute "style" "min-width: 180px;", attribute "tabindex" "0" ]
                [ i [ class "facebook icon" ]
                    []
                , text " "
                , text "ekm"
                , div [ class "menu", attribute "tabindex" "-1" ]
                    [ a [ class "item", href "#/account" ]
                        [ i [ class "edit icon" ]
                            []
                        , text " My Account"
                        ]
                    , a [ class "item", href "#" ]
                        [ i [ class "sign out icon" ]
                            []
                        , text " Logout"
                        ]
                    ]
                ]
            ]
        ]


tableItem : Log -> Html Msg
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
            (List.map (\t -> tagButton t) log.tags)
        , td []
            [ text log.message ]
        , td [ class "collapsing" ]
            [ a [ class "ui mini primary button", href <| "#/logs/" ++ (toString log.id) ]
                [ text "Details" ]
            ]
        ]


tagButton : String -> Html Msg
tagButton t =
    button [ class "ui mini blue label" ]
        [ text t ]


logsView : List Log -> Html Msg
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


type Page
    = LogsMonitor
    | LogsList
    | Docs
    | NotFound


locationParser : Location -> Page
locationParser location =
    let
        _ =
            Debug.log "location: " location

        hash =
            (String.dropLeft 1 location.hash)
    in
        case hash of
            "" ->
                LogsMonitor

            "monitor" ->
                LogsMonitor

            "logs" ->
                LogsList

            "docs" ->
                Docs

            _ ->
                NotFound


main : Program Never
main =
    Navigation.program (makeParser locationParser)
        { init =
            init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , urlUpdate =
            urlUpdate
        }
