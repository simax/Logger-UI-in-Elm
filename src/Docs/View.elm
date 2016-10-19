module Docs.View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (attribute, alt, class, href, src, name, type', placeholder, id)
import Docs.Types exposing (..)


view : Model -> Html Msg
view model =
    div [ class "ui grid" ]
        [ div [ class "padded column" ]
            [ div [ class "ui grid" ]
                [ div [ class "two wide column" ]
                    [ sidebar ]
                , div [ class "twelve wide stretched column" ]
                    [ text model.content ]
                ]
            ]
        ]



-- content : Model -> Html Msg
-- content model =
--     case model.content of
--         DotNetClient ->
--             viewDotNetClient
--
--         DotNetExample ->
--             viewDotNetExample
--
--         ClassicAspClient ->
--             viewClassicAspClient
--
--         ClassicAspExample ->
--             viewClassicAspExample
--
--         JavascriptClient ->
--             viewJavascriptClient
--
--         JavascriptExample ->
--             viewJavascriptExample


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


viewJavascriptClient : Html Msg
viewJavascriptClient =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "the-javascript-client" ]
                [ text "The Javascript Client" ]
            , p []
                [ em []
                    [ text "Currently in development" ]
                ]
            ]
        ]


viewJavascriptExample : Html Msg
viewJavascriptExample =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "examples" ]
                [ text "Examples" ]
            , p []
                [ em []
                    [ text "Coming soon" ]
                ]
            ]
        ]


viewClassicAspClient : Html Msg
viewClassicAspClient =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "classic-asp-client" ]
                [ text "Classic ASP Client" ]
            , p []
                [ em []
                    [ text "The client is currently implemented in the Powershop codebase on the "
                    , strong []
                        [ text "SQLite-Migration Sync" ]
                    , text "branch, so is not currently available for use on the  "
                    , strong []
                        [ text "default" ]
                    , text "branch."
                    ]
                ]
            , h2 [ id "ekm-powershop-" ]
                [ text "EKM (Powershop)" ]
            , p []
                [ text "The client is contained in the "
                , a [ href "http://hg/ekmPowershop/ekmPowershop/file/76a400c8033f/wwwroot/ekmps/data/ekmpowershop_A/logging" ]
                    [ text "logging "
                    , em []
                        [ text "namespace" ]
                    ]
                , text "in the "
                , strong []
                    [ text "EKM" ]
                , text "code."
                ]
            , h3 [ id "how-do-i-use-it-" ]
                [ text "How do I use it?" ]
            , p []
                [ text "You shouldn't need to add it as an "
                , em []
                    [ text "include" ]
                , text ", as it should already be added by the "
                , strong []
                    [ text "global_header_footer_system.asp" ]
                , text "page. Then all you need to do to get the client is:"
                ]
            , pre []
                [ code [ class "lang-vbscript hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "Dim" ]
                    , text "logger : "
                    , span [ class "hljs-keyword" ]
                        [ text "Set" ]
                    , text "logger = LogManager.GetEkmLogger("
                    , span [ class "hljs-string" ]
                        [ text "\"MyLogger\"" ]
                    , text ")"
                    ]
                ]
            , p []
                [ strong []
                    [ em []
                        [ text "Or, if it is set as the default in the LogManager" ]
                    ]
                ]
            , pre []
                [ code [ class "lang-vbscript hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "Dim" ]
                    , text "logger : "
                    , span [ class "hljs-keyword" ]
                        [ text "Set" ]
                    , text "logger = LogManager.GetDefaultLogger("
                    , span [ class "hljs-string" ]
                        [ text "\"MyLogger\"" ]
                    , text ")"
                    ]
                ]
            , p []
                [ em []
                    [ text "In the above example, \"MyLogger\" will be included in the meta of any logs produced by the created logger." ]
                ]
            ]
        ]


viewClassicAspExample : Html Msg
viewClassicAspExample =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "examples" ]
                [ text "Examples" ]
            , h2 [ id "simplest-example" ]
                [ text "Simplest Example" ]
            , p []
                [ em []
                    [ text "It assumes that the default logger is set to the EkmLogger" ]
                ]
            , pre []
                [ code [ class "lang-vbscript hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "Dim" ]
                    , text "logger : "
                    , span [ class "hljs-keyword" ]
                        [ text "Set" ]
                    , text "logger = LogManager.GetDefaultLogger()"
                    , span [ class "hljs-keyword" ]
                        [ text "Dim" ]
                    , span [ class "hljs-built_in" ]
                        [ text "log" ]
                    , text ": "
                    , span [ class "hljs-keyword" ]
                        [ text "Set" ]
                    , span [ class "hljs-built_in" ]
                        [ text "log" ]
                    , text "= LogBuilderHelper.Create() _  .Debug("
                    , span [ class "hljs-string" ]
                        [ text "\"I am debugging something\"" ]
                    , text ") _  .Tag("
                    , span [ class "hljs-string" ]
                        [ text "\"debug\"" ]
                    , text ") _  .Tag("
                    , span [ class "hljs-string" ]
                        [ text "\"testing\"" ]
                    , text ") _  .Meta("
                    , span [ class "hljs-string" ]
                        [ text "\"details\"" ]
                    , text ", "
                    , span [ class "hljs-string" ]
                        [ text "\"Some extra details\"" ]
                    , text ") _  .Meta("
                    , span [ class "hljs-string" ]
                        [ text "\"exception\"" ]
                    , text ", "
                    , span [ class "hljs-string" ]
                        [ text "\"Maybe something went wrong?\"" ]
                    , text ") _  .Build()"
                    , span [ class "hljs-keyword" ]
                        [ text "Call" ]
                    , text "logger."
                    , span [ class "hljs-built_in" ]
                        [ text "Log" ]
                    , text "("
                    , span [ class "hljs-built_in" ]
                        [ text "log" ]
                    , text ")"
                    ]
                ]
            ]
        ]


viewDotNetClient : Html Msg
viewDotNetClient =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "the-net-client" ]
                [ text "The .NET Client" ]
            , p []
                [ a [ href "http://hg/ekmPowershop/EkmLogger.Client/" ]
                    [ img [ alt "NuGet", src "https://img.shields.io/badge/nuget-v1.1.10-blue.svg" ]
                        []
                    ]
                ]
            , p []
                [ strong []
                    [ text "EkmLogger.Client" ]
                , text "is a library for allowing you to easily send logs to the "
                , strong []
                    [ text "EKM Logger" ]
                , text "web service"
                ]
            , p []
                [ text "EkmLogger.Client is available via our private  " ]
            ]
        ]


viewDotNetExample : Html Msg
viewDotNetExample =
    div [ class "ui raised blue segment" ]
        [ div []
            [ h1 [ id "examples" ]
                [ text "Examples" ]
            , h2 [ id "simplest-example" ]
                [ text "Simplest Example" ]
            , pre []
                [ code [ class "lang-csharp hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "public " ]
                    , span [ class "hljs-keyword" ]
                        [ text "class " ]
                    , span [ class "hljs-title" ]
                        [ text "MyAwesomeClass " ]
                    , text "{  "
                    , span [ class "hljs-function" ]
                        [ span [ class "hljs-keyword" ]
                            [ text "public" ]
                        , span [ class "hljs-keyword" ]
                            [ text "void" ]
                        , span [ class "hljs-title" ]
                            [ text "MyAwesomeFunction" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            [ span [ class "hljs-keyword" ]
                                [ text "string" ]
                            , text "myParam"
                            ]
                        , text ")  "
                        ]
                    , text "{    "
                    , span [ class "hljs-comment" ]
                        [ text "// Do some awesome stuff!" ]
                    , span [ class "hljs-keyword" ]
                        [ text "var" ]
                    , text "client = "
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "EkmLoggerClient("
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "EkmLoggerClientConfiguration    {        ServiceUrl = "
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "Uri("
                    , span [ class "hljs-string" ]
                        [ text "\"http://localhost:3000\"" ]
                    , text ")    });    client.PostAsync(LogBuilder.For("
                    , span [ class "hljs-string" ]
                        [ text "\"My Awesome App\"" ]
                    , text ");      .Debug("
                    , span [ class "hljs-string" ]
                        [ text "\"I just got called!\"" ]
                    , text ")      .Tag("
                    , span [ class "hljs-string" ]
                        [ text "\"test\"" ]
                    , text ")      .Meta("
                    , span [ class "hljs-string" ]
                        [ text "\"myParam\"" ]
                    , text ", myParam)      .Build());  }}"
                    ]
                ]
            , h2 [ id "dependency-injection" ]
                [ text "Dependency Injection" ]
            , p []
                [ text "Create a "
                , strong []
                    [ text "Provider" ]
                , text "for the client"
                ]
            , pre []
                [ code [ class "lang-csharp hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "public" ]
                    , span [ class "hljs-keyword" ]
                        [ text "interface" ]
                    , span [ class "hljs-title" ]
                        [ text "IEkmLoggerClientProvider" ]
                    , text "{  "
                    , span [ class "hljs-function" ]
                        [ text "IEkmLoggerClient "
                        , span [ class "hljs-title" ]
                            [ text "GetClient" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            []
                        , text ")"
                        ]
                    , text ";}"
                    , span [ class "hljs-keyword" ]
                        [ text "internal" ]
                    , span [ class "hljs-keyword" ]
                        [ text "class" ]
                    , span [ class "hljs-title" ]
                        [ text "EkmLoggerClientProvider" ]
                    , text ": "
                    , span [ class "hljs-title" ]
                        [ text "IEkmLoggerClientProvider" ]
                    , text "{  "
                    , span [ class "hljs-function" ]
                        [ span [ class "hljs-keyword" ]
                            [ text "public" ]
                        , text "IEkmLoggerClient "
                        , span [ class "hljs-title" ]
                            [ text "GetClient" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            []
                        , text ")  "
                        ]
                    , text "{    "
                    , span [ class "hljs-keyword" ]
                        [ text "return" ]
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "EkmLoggerClient("
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "EkmLoggerClientConfiguration    {        ServiceUrl = "
                    , span [ class "hljs-keyword" ]
                        [ text "new" ]
                    , text "Uri("
                    , span [ class "hljs-string" ]
                        [ text "\"http://localhost:3000\"" ]
                    , text ")    });  }}"
                    ]
                ]
            , p []
                [ text "And inject it in to your class" ]
            , pre []
                [ code [ class "lang-csharp hljs" ]
                    [ span [ class "hljs-keyword" ]
                        [ text "public" ]
                    , span [ class "hljs-keyword" ]
                        [ text "class" ]
                    , span [ class "hljs-title" ]
                        [ text "TestModule" ]
                    , text ": "
                    , span [ class "hljs-title" ]
                        [ text "NancyModule" ]
                    , text "{  "
                    , span [ class "hljs-function" ]
                        [ span [ class "hljs-keyword" ]
                            [ text "public" ]
                        , span [ class "hljs-title" ]
                            [ text "TestModule" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            [ text "IEkmLoggerClientProvider ekmLoggerClientProvider" ]
                        , text ")    : "
                        , span [ class "hljs-title" ]
                            [ text "base" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            [ span [ class "hljs-string" ]
                                [ text "\"/test\"" ]
                            ]
                        , text ")  "
                        ]
                    , text "{    _ekmLoggerClientProvider = ekmLoggerClientProvider;    Get["
                    , span [ class "hljs-string" ]
                        [ text "\"/\"" ]
                    , text "] = GetIndex;  }  "
                    , span [ class "hljs-keyword" ]
                        [ text "private" ]
                    , span [ class "hljs-keyword" ]
                        [ text "readonly" ]
                    , text "IEkmLoggerClientProvider _ekmLoggerClientProvider;  "
                    , span [ class "hljs-function" ]
                        [ span [ class "hljs-keyword" ]
                            [ text "private" ]
                        , span [ class "hljs-keyword" ]
                            [ text "dynamic" ]
                        , span [ class "hljs-title" ]
                            [ text "GetIndex" ]
                        , text "("
                        , span [ class "hljs-params" ]
                            [ span [ class "hljs-keyword" ]
                                [ text "dynamic" ]
                            , text "parameters"
                            ]
                        , text ")  "
                        ]
                    , text "{    "
                    , span [ class "hljs-keyword" ]
                        [ text "var" ]
                    , text "client = _ekmLoggerClientProvider.GetClient();    "
                    , span [ class "hljs-keyword" ]
                        [ text "var" ]
                    , text "log = LogBuilder.For("
                    , span [ class "hljs-string" ]
                        [ text "\"My Nancy App\"" ]
                    , text ")      .Debug("
                    , span [ class "hljs-string" ]
                        [ text "\"Got to the TestModule\"" ]
                    , text ")      .Tag("
                    , span [ class "hljs-string" ]
                        [ text "\"nancy\"" ]
                    , text ")      .Tag("
                    , span [ class "hljs-string" ]
                        [ text "\"test\"" ]
                    , text ")      .Meta("
                    , span [ class "hljs-string" ]
                        [ text "\"CurrentUser\"" ]
                    , text ", Request.CurrentUser)      .Build();    client.PostAsync(log);    "
                    , span [ class "hljs-keyword" ]
                        [ text "return" ]
                    , text "HttpStatusCode.OK;  }}"
                    ]
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
