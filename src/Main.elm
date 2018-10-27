module Main exposing (main)

import Rating exposing (..)
import Browser
import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Element.Font as Font


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


button : Msg -> String -> Element Msg
button msg label =
    Input.button
        [ Border.width 2
        , Border.color <| rgb 0.9 0.9 0.9
        , Border.rounded 5
        , centerX
        , padding 5
        ]
        { onPress = Just msg
        , label = text label
        }


view : Model -> Html Msg
view model =
    layout [] <|
        column
            [ padding 20
            , spacing 10
            , centerX
            , centerY
            ]
            [ el [ Font.size 30, centerX ] <|
                text "★ Rate it! ☆"
            , button Increment "+"
            , el [ centerX ] <|
                Rating.reviewElement model
            , button Decrement "-"
            , button Reset "Reset"
            , Input.text []
                { onChange = \s -> CommentChange s
                , text = model.comment
                , placeholder =
                    Just <|
                        Input.placeholder
                            [ centerX
                            , width shrink
                            ]
                        <|
                            text "Enter comment..."
                , label = Input.labelHidden "Comment:"
                }
            ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
