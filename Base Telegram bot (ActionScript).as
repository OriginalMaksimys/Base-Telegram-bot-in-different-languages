import com.prtelegrambot.core.PRBot;
import com.prtelegrambot.core.PRBotOptions;

const EXIT_COMMAND:String = "exit";

var telegram:PRBot = new PRBot(function(option:PRBotOptions):void {
    option.token = "";
    option.clearUpdatesOnStart = true;
    option.whiteListUsers = new Vector.<int>(); 
    option.admins = new Vector.<int>(); 
    option.botId = 0;
});

telegram.onLogCommon.add(Telegram_OnLogCommon);
telegram.onLogError.add(Telegram_OnLogError);

telegram.start();

function Telegram_OnLogError(ex:Error, id:int = 0):void {
    trace(new Date().toLocaleString() + ":" + ex.message);
}

function Telegram_OnLogCommon(msg:String, typeEvent:int, color:uint):void {
    trace(new Date().toLocaleString() + ":" + msg);
}

while (true) {
    var result:String = Console.input;
    if (result.toLowerCase() == EXIT_COMMAND) {
        System.exit(0);
    }
}

import com.prtelegrambot.core.PRBot;
import com.prtelegrambot.core.PRBotOptions;

const EXIT_COMMAND:String = "exit";

var telegram:PRBot = new PRBot(function(option:PRBotOptions):void {
    option.token = "";
    option.clearUpdatesOnStart = true;
    option.whiteListUsers = new Vector.<int>(); 
    option.admins = new Vector.<int>(); 
    option.botId = 0;
});

telegram.onLogCommon.add(Telegram_OnLogCommon);
telegram.onLogError.add(Telegram_OnLogError);

telegram.start();

function Telegram_OnLogError(ex:Error, id:int = 0):void {
    trace(new Date().toLocaleString() + ":" + ex.message);
}

function Telegram_OnLogCommon(msg:String, typeEvent:int, color:uint):void {
    trace(new Date().toLocaleString() + ":" + msg);
}

while (true) {
    var result:String = Console.input;
    if (result.toLowerCase() == EXIT_COMMAND) {
        System.exit(0);
    }
}

