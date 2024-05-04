import 'package:prtelegrambot_core/prtelegrambot_core.dart';

const String EXIT_COMMAND = "exit";

final telegram = PRBot(
  (option) {
    option.token = "";
    option.clearUpdatesOnStart = true;
    option.whiteListUsers = [];
    option.admins = [];
    option.botId = 0;
  },
);

telegram.onLogCommon.listen(Telegram_OnLogCommon);
telegram.onLogError.listen(Telegram_OnLogError);

Future<void> main() async {
  await telegram.start();

  while (true) {
    final result = await stdin.readLine();
    if (result?.toLowerCase() == EXIT_COMMAND) {
      exit(0);
    }
  }
}

void Telegram_OnLogError(Exception ex, int? id) {
  stderr.writeln('\x1B[31m${DateTime.now()}:$ex\x1B[0m');
}

void Telegram_OnLogCommon(String msg, dynamic typeEvent, ConsoleColor color) {
  stdout.writeln('\x1B[32m${DateTime.now()}:$msg\x1B[0m');
}

