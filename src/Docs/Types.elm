module Docs.Types exposing (..)

import Http


type alias Model =
    { content : String
    }


type alias Documentation =
    String


type DocContent
    = DocsHome
    | DotNetClient
    | DotNetExample
    | ClassicAspClient
    | ClassicAspExample
    | JavascriptClient
    | JavascriptExample


type Msg
    = Documentation String
    | Content DocContent
    | Fail Http.Error
