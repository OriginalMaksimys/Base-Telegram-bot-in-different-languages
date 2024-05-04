open Prtelegrambot.Core

let exit_command = "exit"

let telegram =
  let bot_options =
    { token = ""
    ; clear_updates_on_start = true
    ; white_list_users = []
    ; admins = []
    ; bot_id = 0
    }
  in
  new PRBot bot_options

let telegram_on_log_error (ex : exn) (id : int64 option) =
  Console.foreground_color <- ConsoleColor.Red
  let error_msg = Printf.sprintf "%s:%s" (DateTime.now ()) (Printexc.to_string ex)
  Console.write_line error_msg
  Console.reset_color ()

let telegram_on_log_common (msg : string) (type_event : 'a) (color : ConsoleColor) =
  Console.foreground_color <- ConsoleColor.Green
  let message = Printf.sprintf "%s:%s" (DateTime.now ()) msg
  Console.write_line message
  Console.reset_color ()

telegram.on_log_common |> Event.add telegram_on_log_common
telegram.on_log_error |> Event.add telegram_on_log_error

Async.run (telegram.start ())

while true do
  let result = Console.read_line ()
  if String.lowercase_ascii result = exit_command then
    Environment.exit 0
done

