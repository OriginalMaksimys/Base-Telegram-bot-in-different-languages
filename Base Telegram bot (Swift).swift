import TelegramBotSDK

let EXIT_COMMAND = "exit"

let telegram = TelegramBot(token: "") {
    $0.clearUpdatesOnStart = true
    $0.whiteListUsers = []
    $0.admins = []
    $0.botId = 0
}

telegram.onLogCommon = { msg, typeEvent, color in
    print("\(Date()):\(msg)", terminator: "")
}

telegram.onLogError = { ex, id in
    print("\(Date()):\(ex)", terminator: "")
}

try await telegram.start()

while true {
    if let result = readLine(), result.lowercased() == EXIT_COMMAND {
        exit(0)
    }
}

