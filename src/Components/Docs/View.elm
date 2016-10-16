module Components.Docs.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, src, name, type', placeholder, id)


type alias Model =
    {}


type Msg
    = DotNetClient
    | DotNetExample
    | ClassicAspClient
    | ClassicAspExample
    | JavascriptClient
    | JavascriptExample


root : Model -> Html Msg
root model =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div [ class "ui grid" ]
                [ div [ class "two wide column" ]
                    [ div [ class "ui vertical fluid menu" ]
                        [ div [ class "item" ]
                            [ a [ class "header", href "#/docs/home" ]
                                [ text "EKM Logger" ]
                            ]
                        , div [ class "item" ]
                            [ div [ class "header" ]
                                [ text ".NET" ]
                            , div [ class "menu" ]
                                [ a [ class "item", href "#/docs/dot_net/client" ]
                                    [ text "Client" ]
                                , a [ class "item", href "#/docs/dot_net/examples" ]
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
                    ]
                , div [ class "twelve wide stretched column" ]
                    [ div [ class "ui raised blue segment" ]
                        [ div []
                            [ h1 [ id "examples" ]
                                [ text "Examples" ]
                            , p []
                                [ em []
                                    [ text "Coming soon" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
