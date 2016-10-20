module Docs.Types exposing (..)

import Http


type alias Model =
    { content : String
    }


type alias Documentation =
    String


type
    DocContent
    -- "#/docs/dot_net/client"
    = DocsHome
      -- "#/docs/hoeme.md"
    | DotNetClient
      -- "#/docs/dot_net/examples"
    | DotNetExample
      -- "#/docs/classic_asp/client"
    | ClassicAspClient
      -- "#/docs/classic_asp/examples"
    | ClassicAspExample
      -- "#/docs/javascript/client"
    | JavascriptClient
      -- "#/docs/javascript/examples"
    | JavascriptExample


type Msg
    = Documentation String
    | Content DocContent
    | Fail Http.Error
