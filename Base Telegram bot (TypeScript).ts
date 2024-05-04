import { PRBot } from 'PRTelegramBot.Core';

const EXIT_COMMAND: string = 'exit';

const telegram: PRBot = new PRBot({
    Token: '',
    ClearUpdatesOnStart: true,
    WhiteListUsers: [],
    Admins: [],
    BotId: 0
});

telegram.OnLogCommon += Telegram_OnLogCommon;
telegram.OnLogError += Telegram_OnLogError;

await telegram.Start();

function Telegram_OnLogError(ex: Error, id?: number | null): void {
    console.foregroundColor = 'red';
    const errorMsg: string = `${new Date().toISOString()}:${ex}`;
    console.log(errorMsg);
    console.resetColor();
}

function Telegram_OnLogCommon(msg: string, typeEvent: any, color: string): void {
    console.foregroundColor = 'green';
    const message: string = `${new Date().toISOString()}:${msg}`;
    console.log(message);
    console.resetColor();
}

while (true) {
    const result: string | null = await console.readLine();
    if (result?.toLowerCase() === EXIT_COMMAND) {
        process.exit(0);
    }
}

