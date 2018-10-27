module Main exposing (main)

import Rating exposing (..)
import Browser
import Html exposing (Html, button, div, h1, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)


type alias Model =
    { rating : Rating
    , comment : String
    }


initialModel : Model
initialModel =
    { rating = Rating.init
    , comment = ""
    }


type Msg
    = Increment
    | Decrement
    | Reset
    | CommentChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | rating = Rating.increase model.rating }

        Decrement ->
            { model | rating = Rating.decrease model.rating }

        Reset ->
            initialModel

        CommentChange newText ->
            { model | comment = newText }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "★ Rate it! ☆" ]
        , button [ onClick Increment ] [ text "+1" ]
        , div []
            [ text <| Rating.toStars model.rating
            , text model.comment
            ]
        , button [ onClick Decrement ] [ text "-1" ]
        , div [] [ button [ onClick Reset ] [ text "Reset" ] ]
        , div []
            [ input
                [ placeholder "Enter comment..."
                , value model.comment
                , onInput CommentChange
                ]
                []
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
