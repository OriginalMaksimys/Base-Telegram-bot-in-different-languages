require 'prtelegrambot-core'

EXIT_COMMAND = "exit"

telegram = PRTelegramBot::Core::PRBot.new do |option|
  option.token = ""
  option.clear_updates_on_start = true
  option.white_list_users = []
  option.admins = []
  option.bot_id = 0
end

telegram.on_log_common do |msg, type_event, color|
  puts "\e[32m#{Time.now}:#{msg}\e[0m"
end

telegram.on_log_error do |ex, id|
  puts "\e[31m#{Time.now}:#{ex}\e[0m"
end

telegram.start

loop do
  result = gets.chomp
  if result.downcase == EXIT_COMMAND
    exit
  end
end

