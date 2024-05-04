import com.prtelegrambot.core.PRBot
import java.time.LocalDateTime
import scala.collection.mutable.ListBuffer

val EXIT_COMMAND = "exit"

val telegram = new PRBot(options => {
  options.Token = ""
  options.ClearUpdatesOnStart = true
  options.WhiteListUsers = ListBuffer[Long]()
  options.Admins = ListBuffer[Long]()
  options.BotId = 0
})

telegram.OnLogCommon += Telegram_OnLogCommon
telegram.OnLogError += Telegram_OnLogError

telegram.Start().await()

def Telegram_OnLogError(ex: Exception, id: Option[Long]): Unit = {
  Console.ForegroundColor = ConsoleColor.Red
  val errorMsg = s"${LocalDateTime.now}:$ex"
  Console.WriteLine(errorMsg)
  Console.ResetColor()
}

def Telegram_OnLogCommon(msg: String, typeEvent: Enum, color: ConsoleColor): Unit = {
  Console.ForegroundColor = ConsoleColor.Green
  val message = s"${LocalDateTime.now}:$msg"
  Console.WriteLine(message)
  Console.ResetColor()
}

while (true) {
  val result = Console.readLine()
  if (result.toLowerCase == EXIT_COMMAND) {
    System.exit(0)
  }
}

