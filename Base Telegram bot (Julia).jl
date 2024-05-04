using PRTelegramBot

const EXIT_COMMAND = "exit"

telegram = PRBot(;
    Token = "",
    ClearUpdatesOnStart = true,
    WhiteListUsers = [Int64[]],
    Admins = [Int64[]],
    BotId = 0
)

function Telegram_OnLogError(ex, id)
    println(Base.color_normal(Base.error_color(), "$(DateTime.now()):$ex"))
    Base.reset_color()
end

function Telegram_OnLogCommon(msg, typeEvent, color)
    println(Base.color_normal(Base.info_color(), "$(DateTime.now()):$msg"))
    Base.reset_color()
end

telegram.OnLogCommon += Telegram_OnLogCommon
telegram.OnLogError += Telegram_OnLogError

start(telegram)

while true
    result = readline()
    if lowercase(result) == EXIT_COMMAND
        exit(0)
    end
end

