(import (prtelegrambot.core))

(define exit-command "exit")

(define telegram
  (make-instance 'prbot
                 (lambda (option)
                   (set-token! option "")
                   (set-clear-updates-on-start! option #t)
                   (set-white-list-users! option '())
                   (set-admins! option '())
                   (set-bot-id! option 0))))

(set-on-log-common! telegram
                   (lambda (msg type-event color)
                     (set-console-foreground-color! 'green)
                     (display (format "~a:~a" (current-date-time) msg))
                     (newline)
                     (reset-console-color!)))

(set-on-log-error! telegram
                  (lambda (ex id)
                    (set-console-foreground-color! 'red)
                    (display (format "~a:~a" (current-date-time) ex))
                    (newline)
                    (reset-console-color!)))

(start! telegram)

(define (main-loop)
  (let ((result (read-line)))
    (if (string=? (string-downcase result) exit-command)
        (exit 0)
        (main-loop))))

(main-loop)

