use prtelegrambot_core::PRBot;
use std::collections::HashSet;
use std::error::Error;
use std::io::{self, Write};

const EXIT_COMMAND: &str = "exit";

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    let mut telegram = PRBot::new(|option| {
        option.token = String::new();
        option.clear_updates_on_start = true;
        option.white_list_users = HashSet::new();
        option.admins = HashSet::new();
        option.bot_id = 0;
    });

    telegram.on_log_common(|msg, type_event, color| {
        println!(
            "\x1b[32m{}: {}\x1b[0m",
            chrono::Local::now().format("%Y-%m-%d %H:%M:%S"),
            msg
        );
    });

    telegram.on_log_error(|ex, id| {
        eprintln!(
            "\x1b[31m{}: {}\x1b[0m",
            chrono::Local::now().format("%Y-%m-%d %H:%M:%S"),
            ex
        );
    });

    telegram.start().await?;

    loop {
        let mut input = String::new();
        io::stdout().flush()?;
        io::stdin().read_line(&mut input)?;

        if input.trim().to_lowercase() == EXIT_COMMAND {
            break;
        }
    }

    Ok(())
}

