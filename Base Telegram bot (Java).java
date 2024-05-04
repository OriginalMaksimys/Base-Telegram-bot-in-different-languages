import com.prtelegrambot.core.PRBot;
import java.util.ArrayList;
import java.util.List;

public class TelegramBotExample {
    private static final String EXIT_COMMAND = "exit";

    public static void main(String[] args) {
        PRBot telegram = new PRBot(options -> {
            options.setToken("");
            options.setClearUpdatesOnStart(true);
            options.setWhiteListUsers(new ArrayList<>());
            options.setAdmins(new ArrayList<>());
            options.setBotId(0);
        });

        telegram.setOnLogCommon((msg, typeEvent, color) -> {
            System.out.println(String.format("%s:%s", DateTime.now(), msg));
        });

        telegram.setOnLogError((ex, id) -> {
            System.out.println(String.format("%s:%s", DateTime.now(), ex));
        });

        telegram.start();

        while (true) {
            String result = System.console().readLine();
            if (result.toLowerCase().equals(EXIT_COMMAND)) {
                System.exit(0);
            }
        }
    }
}

