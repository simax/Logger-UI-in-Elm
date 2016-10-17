module Docs.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (attribute, class, href, src, name, type', placeholder, id)
import Docs.Types exposing (..)


view : Model -> Html Msg
view model =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div [ class "ui grid" ]
                [ div [ class "two wide column" ]
                    [ sidebar ]
                , div [ class "twelve wide stretched column" ]
                    [ content model ]
                ]
            ]
        ]


content : Model -> Html Msg
content model =
    case model.content of
        DotNetClient ->
            viewDotNetClient

        DotNetExample ->
            viewDotNetExample

        _ ->
            viewBlank


viewBlank : Html Msg
viewBlank =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "blank" ]
                [ text " " ]
            , p []
                [ em []
                    [ text "" ]
                ]
            ]
        ]


viewDotNetClient : Html Msg
viewDotNetClient =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "examples" ]
                [ text "DotNet Client" ]
            , p []
                [ em []
                    [ text "DotNet client information is coming soon..." ]
                ]
            ]
        ]


viewDotNetExample : Html Msg
viewDotNetExample =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "examples" ]
                [ text "Examples" ]
            , p []
                [ em []
                    [ text "DotNet example is coming soon..." ]
                ]
            ]
        ]


sidebar : Html Msg
sidebar =
    div [ class "ui vertical fluid menu" ]
        [ div [ class "item" ]
            [ a [ class "header", href "#/docs/home" ]
                [ text "EKM Logger" ]
            ]
        , div [ class "item" ]
            [ div [ class "header" ]
                [ text ".NET" ]
            , div [ class "menu" ]
                [ a [ class "item", onClick (Content DotNetClient) ]
                    [ text "Client" ]
                , a [ class "item", onClick (Content DotNetExample) ]
                    [ text "Examples" ]
                ]
            ]
        , div [ class "item" ]
            [ div [ class "header" ]
                [ text "Classic ASP" ]
            , div [ class "menu" ]
                [ a [ class "item", href "#/docs/classic_asp/client" ]
                    [ text "Client" ]
                , a [ class "item", href "#/docs/classic_asp/examples" ]
                    [ text "Examples" ]
                ]
            ]
        , div [ class "item" ]
            [ div [ class "header" ]
                [ text "Javascript" ]
            , div [ class "menu" ]
                [ a [ class "item", href "#/docs/javascript/client" ]
                    [ text "Client" ]
                , a [ class "item active", href "#/docs/javascript/examples" ]
                    [ text "Examples" ]
                ]
            ]
        ]
