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
    [ DocInfo DocsHome "" "http://localhost:8080/static/markdown/home.md"
    , DocInfo DotNetClient "" "http://localhost:8080/static/markdown/dot_net/client.md"
    , DocInfo DotNetExample "" "http://localhost:8080/static/markdown/dot_net/examples.md"
    , DocInfo ClassicAspClient "" "http://localhost:8080/static/markdown/classic_asp/client.md"
    , DocInfo ClassicAspExample "" "http://localhost:8080/static/markdown/classic_asp/examples.md"
    , DocInfo JavascriptClient "" "http://localhost:8080/static/markdown/javascript/client.md"
    , DocInfo JavascriptExample "" "http://localhost:8080/static/markdown/javascript/examples.md"
    ]


type Msg
    = SetDocumentContent String
    | Content DocType
    | Fail Http.Error
