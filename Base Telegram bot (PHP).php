use PRTelegramBot\Core\PRBot;

const EXIT_COMMAND = "exit";

$telegram = new PRBot([
    'Token' => '',
    'ClearUpdatesOnStart' => true,
    'WhiteListUsers' => [],
    'Admins' => [],
    'BotId' => 0,
]);

$telegram->OnLogCommon(function($msg, $typeEvent, $color) {
    echo date('Y-m-d H:i:s') . ": " . $msg . PHP_EOL;
});

$telegram->OnLogError(function($ex, $id) {
    echo "\033[1;31m" . date('Y-m-d H:i:s') . ": " . $ex . "\033[0m" . PHP_EOL;
});

$telegram->start();

while (true) {
    $result = readline();
    if (strtolower($result) == EXIT_COMMAND) {
        exit(0);
    }
}

