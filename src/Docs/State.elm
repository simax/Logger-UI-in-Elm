module Docs.State exposing (..)

import Docs.Types exposing (..)


initModel : Model
initModel =
    { content = DotNetClient }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Content DotNetClient ->
            { model | content = DotNetClient }

        Content DotNetExample ->
            { model | content = DotNetExample }

        Content ClassicAspClient ->
            { model | content = ClassicAspClient }

        Content ClassicAspExample ->
            { model | content = ClassicAspExample }

        Content JavascriptClient ->
            { model | content = JavascriptClient }

        Content JavascriptExample ->
            { model | content = JavascriptExample }
