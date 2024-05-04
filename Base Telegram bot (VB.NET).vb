Imports PRTelegramBot.Core

Const EXIT_COMMAND As String = "exit"

Dim telegram As New PRBot(Function(option)
                             option.Token = ""
                             option.ClearUpdatesOnStart = True
                             option.WhiteListUsers = New List(Of Long)() {}
                             option.Admins = New List(Of Long)() {}
                             option.BotId = 0
                         End Function)

AddHandler telegram.OnLogCommon, AddressOf Telegram_OnLogCommon
AddHandler telegram.OnLogError, AddressOf Telegram_OnLogError

Await telegram.Start()

Sub Telegram_OnLogError(ex As Exception, id As Long?)
    Console.ForegroundColor = ConsoleColor.Red
    Dim errorMsg As String = $"{DateTime.Now}:{ex}"
    Console.WriteLine(errorMsg)
    Console.ResetColor()
End Sub

Sub Telegram_OnLogCommon(msg As String, typeEvent As [Enum], color As ConsoleColor)
    Console.ForegroundColor = ConsoleColor.Green
    Dim message As String = $"{DateTime.Now}:{msg}"
    Console.WriteLine(message)
    Console.ResetColor()
End Sub

While True
    Dim result As String = Console.ReadLine()
    If result.ToLower() = EXIT_COMMAND Then
        Environment.Exit(0)
    End If
End While

