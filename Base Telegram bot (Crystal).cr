require "telegram_bot"

EXIT_COMMAND = "exit"

telegram = TelegramBot.new do |option|
  option.token = ""
  option.clear_updates_on_start = true
  option.white_list_users = [] of Int64
  option.admins = [] of Int64
  option.bot_id = 0
end

telegram.on_log_common do |msg, type_event, color|
  puts "#{Time.now}:#{msg}".colorize(:green)
end

telegram.on_log_error do |ex, id|
  puts "#{Time.now}:#{ex}".colorize(:red)
end

telegram.start

loop do
  result = gets
  if result.try(&.downcase) == EXIT_COMMAND
    exit
  end
end

