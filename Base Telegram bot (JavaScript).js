const { PRTelegramBot } = require('prtelegrambot-core');

const EXIT_COMMAND = "exit";

const telegram = new PRBot({
  token: "",
  clearUpdatesOnStart: true,
  whiteListUsers: [],
  admins: [],
  botId: 0
});

telegram.on('logCommon', (msg, typeEvent, color) => {
  console.log(`${new Date().toISOString()}: ${msg}`);
});

telegram.on('logError', (ex, id) => {
  console.error(`${new Date().toISOString()}: ${ex}`);
});

telegram.start();

while (true) {
  const result = readline.question();
  if (result.toLowerCase() === EXIT_COMMAND) {
    process.exit(0);
  }
}

