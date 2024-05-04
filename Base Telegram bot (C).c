#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define EXIT_COMMAND "exit"

typedef struct {
    char* token;
    int clearUpdatesOnStart;
    long* whiteListUsers;
    int whiteListUsersSize;
    long* admins;
    int adminsSize;
    int botId;
} PRBotOptions;

typedef struct {
    PRBotOptions options;
    void (*onLogCommon)(char*, int, int);
    void (*onLogError)(char*, long);
} PRBot;

void Telegram_OnLogError(char* ex, long id) {
    printf("\033[1;31m%s:%s\033[0m\n", __TIME__, ex);
}

void Telegram_OnLogCommon(char* msg, int typeEvent, int color) {
    printf("\033[1;32m%s:%s\033[0m\n", __TIME__, msg);
}

void PRBot_Start(PRBot* bot) {
    // Start the bot
}

int main() {
    PRBotOptions options = {
        .token = "",
        .clearUpdatesOnStart = 1,
        .whiteListUsers = NULL,
        .whiteListUsersSize = 0,
        .admins = NULL,
        .adminsSize = 0,
        .botId = 0
    };

    PRBot telegram = {
        .options = options,
        .onLogCommon = Telegram_OnLogCommon,
        .onLogError = Telegram_OnLogError
    };

    PRBot_Start(&telegram);

    char* result;
    while (1) {
        result = readline();
        if (strcmp(result, EXIT_COMMAND) == 0) {
            exit(0);
        }
        free(result);
    }

    return 0;
}

