using Telegram;

private const string EXIT_COMMAND = "exit";

var telegram = new Telegram.Bot(options => {
    options.Token = "";
    options.ClearUpdatesOnStart = true;
    options.WhiteListUsers = new List<int64>() { };
    options.Admins = new List<int64>() { };
    options.BotId = 0;
});

telegram.LogCommon += Telegram_OnLogCommon;
telegram.LogError += Telegram_OnLogError;

telegram.Start();

void Telegram_OnLogError(Exception ex, int64? id) {
    stdout.set_color(ConsoleColor.RED);
    string errorMsg = @"$((GLib.DateTime.now_local()).format("%Y-%m-%d %H:%M:%S")): $ex";
    stdout.puts(errorMsg);
    stdout.reset_color();
}

void Telegram_OnLogCommon(string msg, Telegram.LogType typeEvent, ConsoleColor color) {
    stdout.set_color(ConsoleColor.GREEN);
    string message = @"$((GLib.DateTime.now_local()).format("%Y-%m-%d %H:%M:%S")): $msg";
    stdout.puts(message);
    stdout.reset_color();
}

while (true) {
    string? result = stdin.read_line();
    if (result != null && result.down() == EXIT_COMMAND) {
        Posix.exit(0);
    }
}

