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



-- div
--   [ class "ui fluid multiple search selection dropdown" ]
--   [ input
--     [ name "tags", type' "undefined" ]
--     []
--   , i
--     [ class "dropdown icon" ]
--     []
--   , div
--     [ class "default text" ]
--     [ text "Skills" ]
--   , div
--     [ class "menu" ]
--     [ div
--       [ class "item", data-value "angular" ]
--       [ text "Angular" ]
--     , div
--       [ class "item", data-value "css" ]
--       [ text "CSS" ]
--     , div
--       [ class "item", data-value "design" ]
--       [ text "Graphic Design" ]
--     , div
--       [ class "item", data-value "ember" ]
--       [ text "Ember" ]
--     , div
--       [ class "item", data-value "html" ]
--       [ text "HTML" ]
--     , div
--       [ class "item", data-value "ia" ]
--       [ text "Information Architecture" ]
--     , div
--       [ class "item", data-value "javascript" ]
--       [ text "Javascript" ]
--     , div
--       [ class "item", data-value "mech" ]
--       [ text "Mechanical Engineering" ]
--     , div
--       [ class "item", data-value "meteor" ]
--       [ text "Meteor" ]
--     , div
--       [ class "item", data-value "node" ]
--       [ text "NodeJS" ]
--     , div
--       [ class "item", data-value "plumbing" ]
--       [ text "Plumbing" ]
--     , div
--       [ class "item", data-value "python" ]
--       [ text "Python" ]
--     , div
--       [ class "item", data-value "rails" ]
--       [ text "Rails" ]
--     , div
--       [ class "item", data-value "react" ]
--       [ text "React" ]
--     , div
--       [ class "item", data-value "repair" ]
--       [ text "Kitchen Repair" ]
--     , div
--       [ class "item", data-value "ruby" ]
--       [ text "Ruby" ]
--     , div
--       [ class "item", data-value "ui" ]
--       [ text "UI Design" ]
--     , div
--       [ class "item", data-value "ux" ]
--       [ text "User Experience" ]
--     ]
--   ]
