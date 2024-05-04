with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Telegram_Bot is

   EXIT_COMMAND : constant String := "exit";

   type PRBot is tagged private;

   procedure Start (This : in out PRBot);
   procedure OnLogCommon (This : in out PRBot; Msg : String; TypeEvent : Enum; Color : Ada.Text_IO.Fore_Color);
   procedure OnLogError (This : in out PRBot; Ex : Ada.Exceptions.Exception_Occurrence; Id : Long_Integer);

private

   type PRBot is tagged record
      Token : Unbounded_String;
      ClearUpdatesOnStart : Boolean;
      WhiteListUsers : Long_Integer_Array;
      Admins : Long_Integer_Array;
      BotId : Long_Integer;
   end record;

end Telegram_Bot;

package body Telegram_Bot is

   procedure Start (This : in out PRBot) is
   begin
      null;
   end Start;

   procedure OnLogCommon (This : in out PRBot; Msg : String; TypeEvent : Enum; Color : Ada.Text_IO.Fore_Color) is
   begin
      Ada.Text_IO.Set_Foreground_Color (Ada.Text_IO.Green);
      Ada.Text_IO.Put_Line (Ada.Calendar.Clock'Img & ":" & Msg);
      Ada.Text_IO.Reset_Foreground_Color;
   end OnLogCommon;

   procedure OnLogError (This : in out PRBot; Ex : Ada.Exceptions.Exception_Occurrence; Id : Long_Integer) is
   begin
      Ada.Text_IO.Set_Foreground_Color (Ada.Text_IO.Red);
      Ada.Text_IO.Put_Line (Ada.Calendar.Clock'Img & ":" & Ada.Exceptions.Exception_Information (Ex));
      Ada.Text_IO.Reset_Foreground_Color;
   end OnLogError;

end Telegram_Bot;

with Telegram_Bot;

procedure Main is
   Telegram : Telegram_Bot.PRBot;
begin
   Telegram.Token := To_Unbounded_String ("");
   Telegram.ClearUpdatesOnStart := True;
   Telegram.WhiteListUsers := (others => 0);
   Telegram.Admins := (others => 0);
   Telegram.BotId := 0;

   Telegram.Start;

   loop
      declare
         Result : String := Ada.Text_IO.Get_Line;
      begin
         exit when Result.To_Lower = EXIT_COMMAND;
      end;
   end loop;
end Main;

