#lang racket

(require prtelegrambot/core)

(define EXIT-COMMAND "exit")

(define telegram
  (new-prtelegrambot
   #:token ""
   #:clear-updates-on-start? #t
   #:whitelist-users '()
   #:admins '()
   #:bot-id 0))

(send telegram on-log-common (lambda (msg type-event color)
                              (begin
                                (set-console-foreground-color! 'green)
                                (printf "~a:~a~n" (current-date) msg)
                                (reset-console-color!))))

(send telegram on-log-error (lambda (ex id)
                              (begin
                                (set-console-foreground-color! 'red)
                                (printf "~a:~a~n" (current-date) ex)
                                (reset-console-color!))))

(send telegram start)

(let loop ()
  (let ([result (read-line)])
    (if (equal? (string-downcase result) EXIT-COMMAND)
        (exit 0)
        (loop))))

