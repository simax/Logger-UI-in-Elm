module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, src, name, type', placeholder)
import Html.App as App
import Http
import Task
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional)


--"http://ekmlogger.ekmpowershop.com"
-- "http://localhost:49851/logs"


serverAPI : String
serverAPI =
    "http://localhost:9000/logs"


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
    ( initModel, (fetchLogs serverAPI) )


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
            viewSiteWrapper
                (div
                    []
                    [ logViewPageHeader
                    , logFilters
                    , logsView
                        model.logs
                    ]
                )

        _ ->
            viewSiteWrapper
                (div
                    []
                    [ logViewPageHeader
                    , div [ class "ui middle message aligned center aligned grid error" ] [ text ("Houston, we have a problem: " ++ (Maybe.withDefault "" model.error) ++ " has occured.") ]
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


logFilters : Html Msg
logFilters =
    div [ class "ui segment" ]
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


logViewPageHeader : Html Msg
logViewPageHeader =
    header [ class "ui top menu" ]
        [ div [ class "item" ]
            [ a [ href "#/" ]
                [ img [ attribute "height" "26", src "../static/img/logo.svg" ]
                    []
                ]
            ]
        , a [ class "item", href "#/monitor" ]
            [ text "Monitor" ]
        , a [ class "item", href "#/logs" ]
            [ text "Logs" ]
        , a [ class "item", href "#/docs" ]
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
            [ a [ class "ui mini primary button", href ("#/logs/" ++ (toString log.id)) ]
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


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
