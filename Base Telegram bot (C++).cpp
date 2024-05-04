#include <iostream>
#include <string>
#include <list>
#include <exception>

const std::string EXIT_COMMAND = "exit";

class PRBot {
public:
    PRBot(std::function<void(PRBot&)> options) {
        options(*this);
    }

    void Start() {
        // Start the bot
    }

    void OnLogCommon(std::function<void(std::string, int, ConsoleColor)> handler) {
        m_onLogCommonHandler = handler;
    }

    void OnLogError(std::function<void(std::exception&, long long*)> handler) {
        m_onLogErrorHandler = handler;
    }

private:
    std::string m_token;
    bool m_clearUpdatesOnStart = true;
    std::list<long long> m_whiteListUsers;
    std::list<long long> m_admins;
    long long m_botId = 0;
    std::function<void(std::string, int, ConsoleColor)> m_onLogCommonHandler;
    std::function<void(std::exception&, long long*)> m_onLogErrorHandler;
};

void Telegram_OnLogError(std::exception& ex, long long* id) {
    std::cout << "\033[1;31m" << DateTime::Now() << ":" << ex.what() << "\033[0m" << std::endl;
}

void Telegram_OnLogCommon(std::string msg, int typeEvent, ConsoleColor color) {
    std::cout << "\033[1;32m" << DateTime::Now() << ":" << msg << "\033[0m" << std::endl;
}

int main() {
    PRBot telegram([](PRBot& option) {
        option.m_token = "";
        option.m_clearUpdatesOnStart = true;
        option.m_whiteListUsers = { };
        option.m_admins = { };
        option.m_botId = 0;
    });

    telegram.OnLogCommon(Telegram_OnLogCommon);
    telegram.OnLogError(Telegram_OnLogError);

    telegram.Start();

    std::string result;
    while (true) {
        std::getline(std::cin, result);
        if (result == EXIT_COMMAND) {
            return 0;
        }
    }
}

