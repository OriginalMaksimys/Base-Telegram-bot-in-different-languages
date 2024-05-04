package require PRTelegramBot.Core

set EXIT_COMMAND "exit"

set telegram [PRBot new [list \
    -Token "" \
    -ClearUpdatesOnStart 1 \
    -WhiteListUsers [list ] \
    -Admins [list ] \
    -BotId 0 \
]]

$telegram configure -OnLogCommon [list Telegram_OnLogCommon]
$telegram configure -OnLogError [list Telegram_OnLogError]

$telegram Start

proc Telegram_OnLogError {ex id} {
    puts -nonewline "\033\[1;31m"
    puts "$[clock format [clock seconds]]:[string map {"\n" " "} $ex]"
    puts -nonewline "\033\[0m"
}

proc Telegram_OnLogCommon {msg typeEvent color} {
    puts -nonewline "\033\[1;32m"
    puts "$[clock format [clock seconds]]:$msg"
    puts -nonewline "\033\[0m"
}

while {1} {
    set result [gets stdin]
    if {[string tolower $result] == $EXIT_COMMAND} {
        exit 0
    }
}

