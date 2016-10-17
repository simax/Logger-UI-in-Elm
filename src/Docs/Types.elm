module Docs.Types exposing (..)


type alias Model =
    { content : DocContent
    }


type DocContent
    = DotNetClient
      -- "#/docs/dot_net/client"
    | DotNetExample
      -- "#/docs/dot_net/examples"
    | ClassicAspClient
    | ClassicAspExample
    | JavascriptClient
    | JavascriptExample


type Msg
    = Content DocContent
