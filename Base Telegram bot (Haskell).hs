{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class (liftIO)
import Data.Text (pack, unpack)
import Data.Time (getCurrentTime, formatTime, defaultTimeLocale)
import Network.Telegram.Bot.API
import System.Console.ANSI (setForegroundColor, setSGR, SGR(Reset))
import System.Environment (getArgs, exitSuccess)

-- Constants
exitCommand :: String
exitCommand = "exit"

-- Telegram bot setup
main :: IO ()
main = do
    token <- ""
    let botOptions = defaultTelegramClientOptions
            { telegramToken = pack token
            , telegramClearUpdatesOnStart = True
            , telegramWhiteListUsers = []
            , telegramAdmins = []
            , telegramBotId = 0
            }
    bot <- newTelegramClient botOptions

    -- Event handlers
    onLogError bot $ \ex id -> do
        liftIO $ do
            setForegroundColor Red
            currentTime <- formatTime defaultTimeLocale "%Y-%m-%d %H:%M:%S" <$> getCurrentTime
            let errorMsg = currentTime ++ ":" ++ show ex
            putStrLn errorMsg
            setSGR [Reset]

    onLogCommon bot $ \msg typeEvent color -> do
        liftIO $ do
            setForegroundColor Green
            currentTime <- formatTime defaultTimeLocale "%Y-%m-%d %H:%M:%S" <$> getCurrentTime
            let message = currentTime ++ ":" ++ unpack msg
            putStrLn message
            setSGR [Reset]

    -- Start the bot
    startBot bot

    -- Main loop
    forever $ do
        result <- getLine
        if map toLower result == exitCommand
            then exitSuccess
            else return ()

