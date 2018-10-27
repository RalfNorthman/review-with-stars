module Rating
    exposing
        ( Rating
        , init
        , increase
        , decrease
        , toStars
        , Reviewed
        , reviewElement
        )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


type Rating
    = Rating Int


init : Rating
init =
    Rating 0


increase : Rating -> Rating
increase rating =
    case rating of
        Rating 5 ->
            Rating 5

        Rating x ->
            Rating (x + 1)


decrease : Rating -> Rating
decrease rating =
    case rating of
        Rating 0 ->
            Rating 0

        Rating x ->
            Rating (x - 1)


toStars : Rating -> String
toStars (Rating number) =
    String.repeat number "★"
        ++ String.repeat (5 - number) "☆"


type alias Reviewed a =
    { a | rating : Rating, comment : String }


reviewElement : Reviewed a -> Element msg
reviewElement { rating, comment } =
    let
        charcoal =
            rgb 0.2 0.2 0.2

        yellow =
            rgb 0.9 0.9 0.1

        columnAttributes =
            []

        starsAttributes =
            [ Background.color charcoal
            , Font.color yellow
            , Border.rounded 8
            , paddingXY 5 2
            , centerX
            , moveDown 10
            ]

        starsElement =
            el starsAttributes <| text <| toStars rating

        commentAttributes =
            [ Background.color charcoal
            , Font.color yellow
            , width (shrink |> minimum 140)
            , paddingXY 8 5
            , Border.rounded 10
            , Border.width 1
            , padding 10
            , centerX
            , above starsElement
            ]

        commentElement =
            el commentAttributes <| el [ centerX ] <| text comment
    in
        column []
            [ starsElement
            , commentElement
            ]
