PROGRAM PRTELEGRAMBOT
  USE PRTelegramBot_Core

  IMPLICIT NONE

  CHARACTER(LEN=10), PARAMETER :: EXIT_COMMAND = "exit"
  TYPE(PRBot) :: telegram
  TYPE(PRBotOptions) :: options
  REAL(8) :: id
  CHARACTER(LEN=100) :: result

  ! Initialize the bot
  options%Token = ""
  options%ClearUpdatesOnStart = .TRUE.
  options%WhiteListUsers = [0_8]
  options%Admins = [0_8]
  options%BotId = 0

  telegram = PRBot(options)

  ! Set up event handlers
  CALL telegram%OnLogCommon%Add(Telegram_OnLogCommon)
  CALL telegram%OnLogError%Add(Telegram_OnLogError)

  ! Start the bot
  CALL telegram%Start()

CONTAINS

  SUBROUTINE Telegram_OnLogError(ex, id)
    TYPE(Exception), INTENT(IN) :: ex
    REAL(8), INTENT(IN), OPTIONAL :: id
    CHARACTER(LEN=100) :: errorMsg

    WRITE(*,'(A,A)') ACHAR(27)//'[1;31m', TRIM(ex%ToString())
    WRITE(*,'(A)') ACHAR(27)//'[0m'
  END SUBROUTINE Telegram_OnLogError

  SUBROUTINE Telegram_OnLogCommon(msg, typeEvent, color)
    CHARACTER(LEN=*), INTENT(IN) :: msg
    INTEGER, INTENT(IN) :: typeEvent
    INTEGER, INTENT(IN) :: color
    CHARACTER(LEN=100) :: message

    WRITE(*,'(A,A)') ACHAR(27)//'[1;32m', TRIM(msg)
    WRITE(*,'(A)') ACHAR(27)//'[0m'
  END SUBROUTINE Telegram_OnLogCommon

  DO
    READ(*,'(A)') result
    IF (TRIM(ADJUSTL(result)) == EXIT_COMMAND) THEN
      STOP
    END IF
  END DO

END PROGRAM PRTELEGRAMBOT

