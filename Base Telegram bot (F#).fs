open PRTelegramBot.Core

let exitCommand = "exit"

let telegram = 
    new PRBot(fun option ->
        option.Token <- ""
        option.ClearUpdatesOnStart <- true
        option.WhiteListUsers <- [||]
        option.Admins <- [||]
        option.BotId <- 0)

telegram.OnLogCommon.Add(fun msg typeEvent color ->
    Console.ForegroundColor <- ConsoleColor.Green
    let message = $"{DateTime.Now}:{msg}"
    Console.WriteLine(message)
    Console.ResetColor())

telegram.OnLogError.Add(fun ex id ->
    Console.ForegroundColor <- ConsoleColor.Red
    let errorMsg = $"{DateTime.Now}:{ex}"
    Console.WriteLine(errorMsg)
    Console.ResetColor())

telegram.Start() |> Async.AwaitTask |> Async.RunSynchronously

while true do
    let result = Console.ReadLine()
    if result.ToLower() = exitCommand then
        Environment.Exit(0)

