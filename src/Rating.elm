module Rating
    exposing
        ( Rating
        , init
        , increase
        , decrease
        , toStars
        )


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
