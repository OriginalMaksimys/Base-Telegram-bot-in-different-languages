import os
import sys
from datetime import datetime
from typing import List
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters

EXIT_COMMAND = "exit"

def telegram_on_log_error(update, context):
    ex = context.error
    print(f"{datetime.now()}:{ex}", file=sys.stderr)

def telegram_on_log_common(update, context, msg, type_event, color):
    print(f"{datetime.now()}:{msg}", file=sys.stdout)

def main():
    token = ""
    white_list_users: List[int] = []
    admins: List[int] = []
    bot_id = 0

    updater = Updater(token=token, use_context=True)
    dispatcher = updater.dispatcher

    dispatcher.add_error_handler(telegram_on_log_error)
    dispatcher.add_handler(MessageHandler(Filters.text & ~Filters.command, telegram_on_log_common))

    updater.start_polling()

    while True:
        result = input()
        if result.lower() == EXIT_COMMAND:
            updater.stop()
            sys.exit(0)

if __name__ == '__main__':
    main()

