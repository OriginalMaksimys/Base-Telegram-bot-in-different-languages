use PRTelegramBot::Core;

my $EXIT_COMMAND = "exit";

my $telegram = PRBot->new({
    Token => "",
    ClearUpdatesOnStart => 1,
    WhiteListUsers => [],
    Admins => [],
    BotId => 0
});

$telegram->OnLogCommon(sub {
    my ($msg, $typeEvent, $color) = @_;
    print STDERR "\e[32m[", scalar(localtime), "] $msg\e[0m\n";
});

$telegram->OnLogError(sub {
    my ($ex, $id) = @_;
    print STDERR "\e[31m[", scalar(localtime), "] $ex\e[0m\n";
});

$telegram->Start();

while (1) {
    my $result = <STDIN>;
    chomp $result;
    if (lc($result) eq $EXIT_COMMAND) {
        exit 0;
    }
}

