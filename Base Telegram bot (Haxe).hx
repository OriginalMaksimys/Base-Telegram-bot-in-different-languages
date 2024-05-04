import prtelegrambot.core.PRBot;
import prtelegrambot.core.PRBotOptions;
import haxe.Exception;
import haxe.Timer;
import sys.io.StdTools;

private static inline final EXIT_COMMAND:String = "exit";

var telegram = new PRBot(function(option:PRBotOptions) {
    option.Token = "";
    option.ClearUpdatesOnStart = true;
    option.WhiteListUsers = []; // List<Int>
    option.Admins = []; // List<Int>
    option.BotId = 0;
});

telegram.OnLogCommon += Telegram_OnLogCommon;
telegram.OnLogError += Telegram_OnLogError;

telegram.Start();

function Telegram_OnLogError(ex:Exception, ?id:Null<Int>) {
    StdTools.setTextColor(ConsoleColor.Red);
    var errorMsg = '${Date.now()}:$ex';
    Sys.println(errorMsg);
    StdTools.resetTextColor();
}

function Telegram_OnLogCommon(msg:String, typeEvent:Enum<Dynamic>, color:ConsoleColor) {
    StdTools.setTextColor(ConsoleColor.Green);
    var message = '${Date.now()}:$msg';
    Sys.println(message);
    StdTools.resetTextColor();
}

while (true) {
    var result = StdTools.readLine();
    if (result.toLowerCase() == EXIT_COMMAND) {
        Sys.exit(0);
    }
}

