package main

import (
    "fmt"
    "os"
    "time"

    "github.com/PaulRitter/go-telegram-bot-api"
)

const exitCommand = "exit"

func main() {
    bot, err := tgbotapi.NewBotAPI("")
    if err != nil {
        logError(err, nil)
        return
    }

    bot.ClearUpdates()

    bot.OnLogCommon(logCommon)
    bot.OnLogError(logError)

    if err := bot.Start(); err != nil {
        logError(err, nil)
        return
    }

    for {
        result, _ := fmt.Scanln()
        if result == exitCommand {
            os.Exit(0)
        }
    }
}

func logError(err error, id *int64) {
    fmt.Println(time.Now().Format("2006-01-02 15:04:05"), ": ", err)
}

func logCommon(msg string, typeEvent interface{}, color tgbotapi.ConsoleColor) {
    fmt.Println(time.Now().Format("2006-01-02 15:04:05"), ": ", msg)
}

