module Docs.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (attribute, alt, class, href, src, name, type', placeholder, id)
import Docs.Types exposing (..)
import Markdown


-- defaultOptions : Markdown.Options
-- defaultOptions =
--     { githubFlavored = Just { tables = False, breaks = False }
--     , defaultHighlighting = Nothing
--     , sanitize = False
--     , smartypants = False
--     }


view : Model -> Html Msg
view model =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div [ class "ui grid" ]
                [ div [ class "two wide column" ]
                    [ sidebar ]
                , div [ class "twelve wide stretched column" ]
                    [ div [ class "ui raised blue segment" ]
                        [ div []
                            [ (Markdown.toHtml [] model.content) ]
                        ]
                    ]
                ]
            ]
        ]


sidebar : Html Msg
sidebar =
    div [ class "ui vertical fluid menu" ]
        [ div [ class "item" ]
            [ a [ class "header active", onClick (Content DocsHome) ]
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
                [ a [ class "item", onClick (Content ClassicAspClient) ]
                    [ text "Client" ]
                , a [ class "item", onClick (Content ClassicAspExample) ]
                    [ text "Examples" ]
                ]
            ]
        , div [ class "item" ]
            [ div [ class "header" ]
                [ text "Javascript" ]
            , div [ class "menu" ]
                [ a [ class "item", onClick (Content JavascriptClient) ]
                    [ text "Client" ]
                , a [ class "item active", onClick (Content JavascriptExample) ]
                    [ text "Examples" ]
                ]
            ]
        ]
