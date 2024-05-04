import com.prtelegrambot.core.PRBot
import java.time.LocalDateTime

const val EXIT_COMMAND = "exit"

val telegram = PRBot(
    option = {
        token = ""
        clearUpdatesOnStart = true
        whiteListUsers = listOf()
        admins = listOf()
        botId = 0
    }
)

telegram.onLogCommon += ::Telegram_OnLogCommon
telegram.onLogError += ::Telegram_OnLogError

suspend fun main() {
    telegram.start()

    while (true) {
        val result = readLine()
        if (result?.toLowerCase() == EXIT_COMMAND) {
            exitProcess(0)
        }
    }
}

fun Telegram_OnLogError(ex: Exception, id: Long?) {
    println(ConsoleColor.Red, "${LocalDateTime.now()}: $ex")
}

fun Telegram_OnLogCommon(msg: String, typeEvent: Enum<*>, color: ConsoleColor) {
    println(ConsoleColor.Green, "${LocalDateTime.now()}: $msg")
}

fun println(color: ConsoleColor, message: String) {
    System.setOut(System.out.withColor(color))
    println(message)
    System.setOut(System.out.withDefaultColor())
}

fun System.out.withColor(color: ConsoleColor): java.io.PrintStream {
    return System.out.apply { this.flush(); this.format("\u001B[%dm", color.value) }
}

fun System.out.withDefaultColor(): java.io.PrintStream {
    return System.out.apply { this.flush(); this.format("\u001B[0m") }
}

enum class ConsoleColor(val value: Int) {
    Red(31),
    Green(32)
}

