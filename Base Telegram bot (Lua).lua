-- Import the required library
local PRTelegramBot = require("PRTelegramBot.Core")

-- Define the exit command
local EXIT_COMMAND = "exit"

-- Create a new PRBot instance
local telegram = PRTelegramBot.PRBot({
    Token = "",
    ClearUpdatesOnStart = true,
    WhiteListUsers = {},
    Admins = {},
    BotId = 0
})

-- Set up event handlers
telegram:OnLogCommon(function(msg, typeEvent, color)
    io.write(os.date() .. ":" .. msg .. "\n")
end)

telegram:OnLogError(function(ex, id)
    io.write(os.date() .. ":" .. tostring(ex) .. "\n")
end)

-- Start the bot
telegram:Start()

-- Main loop
while true do
    local result = io.read("*l")
    if string.lower(result) == EXIT_COMMAND then
        os.exit(0)
    end
end

