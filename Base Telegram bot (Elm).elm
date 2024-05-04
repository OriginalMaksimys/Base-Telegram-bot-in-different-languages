import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Task

-- Constants
EXIT_COMMAND : String
EXIT_COMMAND = "exit"

-- Bot Configuration
type alias BotOptions =
    { token : String
    , clearUpdatesOnStart : Bool
    , whiteListUsers : List Int
    , admins : List Int
    , botId : Int
    }

initBotOptions : BotOptions
initBotOptions =
    { token = ""
    , clearUpdatesOnStart = True
    , whiteListUsers = []
    , admins = []
    , botId = 0
    }

type alias PRBot =
    { options : BotOptions
    , onLogCommon : String -> Enum -> ConsoleColor -> Cmd msg
    , onLogError : Exception -> Maybe Int -> Cmd msg
    , start : Cmd msg
    }

initPRBot : BotOptions -> (Exception -> Maybe Int -> Cmd msg) -> (String -> Enum -> ConsoleColor -> Cmd msg) -> PRBot
initPRBot options onLogError onLogCommon =
    { options = options
    , onLogCommon = onLogCommon
    , onLogError = onLogError
    , start = Task.succeed () |> Task.perform (\_ -> Cmd.none)
    }

-- Telegram Event Handlers
type Enum
    = LogCommon
    | LogError

type alias Exception =
    { message : String }

telegram : PRBot
telegram =
    initPRBot initBotOptions
        (\ex id ->
            case id of
                Just userId ->
                    Cmd.batch
                        [ onLogError ex (Just userId)
                        , Console.setForegroundColor Console.Color.red
                        , Console.log (String.join ":" [ DateTime.now, ex.message ])
                        , Console.resetColor
                        ]

                Nothing ->
                    Cmd.batch
                        [ onLogError ex Nothing
                        , Console.setForegroundColor Console.Color.red
                        , Console.log (String.join ":" [ DateTime.now, ex.message ])
                        , Console.resetColor
                        ]
        )
        (\msg typeEvent color ->
            Cmd.batch
                [ onLogCommon msg typeEvent color
                , Console.setForegroundColor Console.Color.green
                , Console.log (String.join ":" [ DateTime.now, msg ])
                , Console.resetColor
                ]
        )

-- Main Loop
main : Program () () Msg
main =
    Browser.element
        { init = \_ -> ( (), Cmd.none )
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        , view = \_ -> Html.text ""
        }

type Msg
    = Exit

update : Msg -> model -> ( model, Cmd Msg )
update msg model =
    case msg of
        Exit ->
            ( model, Process.exit 0 )

subscriptions : model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Console.onLine
            (\line ->
                if String.toLower line == EXIT_COMMAND then
                    Exit

                else
                    Exit
            )
        ]

