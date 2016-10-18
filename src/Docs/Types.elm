module Docs.Types exposing (..)


type alias Model =
    { content : DocContent
    }


type
    DocContent
    -- "#/docs/dot_net/client"
    = DotNetClient
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
    = Content DocContent
