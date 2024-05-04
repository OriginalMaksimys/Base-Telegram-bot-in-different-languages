uses
  PRTelegramBot.Core;

const
  EXIT_COMMAND = 'exit';

var
  telegram: PRBot;

procedure Telegram_OnLogError(ex: Exception; id: Int64);
begin
  Console.ForegroundColor := ConsoleColor.Red;
  Console.WriteLine(Format('%s:%s', [DateTimeToStr(Now), ex.Message]));
  Console.ResetColor;
end;

procedure Telegram_OnLogCommon(msg: string; typeEvent: Enum; color: ConsoleColor);
begin
  Console.ForegroundColor := ConsoleColor.Green;
  Console.WriteLine(Format('%s:%s', [DateTimeToStr(Now), msg]));
  Console.ResetColor;
end;

begin
  telegram := PRBot.Create(
    procedure(option: PRBotOptions)
    begin
      option.Token := '';
      option.ClearUpdatesOnStart := True;
      option.WhiteListUsers := TList<Int64>.Create;
      option.Admins := TList<Int64>.Create;
      option.BotId := 0;
    end);

  telegram.OnLogCommon += Telegram_OnLogCommon;
  telegram.OnLogError += Telegram_OnLogError;

  telegram.Start;

  while True do
  begin
    var result := Console.ReadLine;
    if SameText(result, EXIT_COMMAND) then
      Exit;
  end;
end.

