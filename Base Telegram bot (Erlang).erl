-module(prtelegrambot_core).
-export([start/0]).

-define(EXIT_COMMAND, "exit").

start() ->
    Telegram = prtelegrambot_core_bot:new(#{
        token => "",
        clear_updates_on_start => true,
        white_list_users => [],
        admins => [],
        bot_id => 0
    }),
    prtelegrambot_core_bot:add_log_common_handler(Telegram, fun telegram_on_log_common/3),
    prtelegrambot_core_bot:add_log_error_handler(Telegram, fun telegram_on_log_error/2),
    prtelegrambot_core_bot:start(Telegram),
    loop().

telegram_on_log_error(Exception, Id) ->
    io:format("\x1b[31m~p:~p\x1b[0m~n", [erlang:localtime(), Exception]).

telegram_on_log_common(Msg, TypeEvent, Color) ->
    io:format("\x1b[32m~p:~s\x1b[0m~n", [erlang:localtime(), Msg]).

loop() ->
    case io:get_line("") of
        ?EXIT_COMMAND ++ "\n" ->
            init:stop();
        _ ->
            loop()
    end.

