library(PRTelegramBot.Core)

EXIT_COMMAND <- "exit"

telegram <- PRBot$new(list(
  Token = "",
  ClearUpdatesOnStart = TRUE,
  WhiteListUsers = list(),
  Admins = list(),
  BotId = 0
))

telegram$OnLogCommon <- function(msg, typeEvent, color) {
  cat(paste0(Sys.time(), ":", msg, "\n"), col = "green")
}

telegram$OnLogError <- function(ex, id) {
  cat(paste0(Sys.time(), ":", ex, "\n"), col = "red")
}

telegram$Start()

while (TRUE) {
  result <- readline()
  if (tolower(result) == EXIT_COMMAND) {
    quit()
  }
}

