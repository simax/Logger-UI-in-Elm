module Docs.Types exposing (..)

import Http


type alias Model =
    { content : String
    }


type alias SetDocumentContent =
    String


type DocType
    = DocsHome
    | DotNetClient
    | DotNetExample
    | ClassicAspClient
    | ClassicAspExample
    | JavascriptClient
    | JavascriptExample


type alias DocInfo =
    { docType : DocType
    , docHash : String
    , url : String
    }


documents : List DocInfo
documents =
    [ DocInfo DocsHome "" "static/markdown/home.md"
    , DocInfo DotNetClient "" "static/markdown/dot_net/client.md"
    , DocInfo DotNetExample "" "static/markdown/dot_net/examples.md"
    , DocInfo ClassicAspClient "" "static/markdown/classic_asp/client.md"
    , DocInfo ClassicAspExample "" "static/markdown/classic_asp/examples.md"
    , DocInfo JavascriptClient "" "static/markdown/javascript/client.md"
    , DocInfo JavascriptExample "" "static/markdown/javascript/examples.md"
    ]


type Msg
    = SetDocumentContent String
    | Content DocType
    | Fail Http.Error
