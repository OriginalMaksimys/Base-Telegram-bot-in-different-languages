import com.pengrad.telegrambot.TelegramBot
import com.pengrad.telegrambot.UpdatesListener
import com.pengrad.telegrambot.model.Update
import com.pengrad.telegrambot.request.SendMessage
import java.time.LocalDateTime

final String EXIT_COMMAND = "exit"

def telegram = new TelegramBot.Builder("")
    .token()
    .clearUpdatesOnStart(true)
    .whiteListedUserIds([])
    .adminIds([])
    .botId(0)
    .build()

telegram.setUpdatesListener { updates ->
    updates.each { update ->
        handleUpdate(update)
    }
    UpdatesListener.CONFIRMED_UPDATES_ALL
}

void handleUpdate(Update update) {
    try {
        // Handle the update
    } catch (Exception ex) {
        logError(ex, update.message()?.chat()?.id())
    }
}

void logError(Exception ex, Long id) {
    println("\u001B[31m${LocalDateTime.now()}:$ex\u001B[0m")
}

void logCommon(String msg, Enum typeEvent, ConsoleColor color) {
    println("\u001B[32m${LocalDateTime.now()}:$msg\u001B[0m")
}

while (true) {
    String result = System.console().readLine()
    if (result.toLowerCase() == EXIT_COMMAND) {
        System.exit(0)
    }
}

