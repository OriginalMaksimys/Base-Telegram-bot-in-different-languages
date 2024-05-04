(require 'prtelegrambot.core)

(defparameter *exit-command* "exit")

(defparameter *telegram* (make-instance 'prtelegrambot.core:prbot
                                       :option (make-instance 'prtelegrambot.core:prbot-option
                                                              :token ""
                                                              :clear-updates-on-start t
                                                              :white-list-users (list)
                                                              :admins (list)
                                                              :bot-id 0)))

(setf (prtelegrambot.core:on-log-common *telegram*) #'telegram-on-log-common)
(setf (prtelegrambot.core:on-log-error *telegram*) #'telegram-on-log-error)

(prtelegrambot.core:start *telegram*)

(defun telegram-on-log-error (ex id)
  (format t "~a:~a~%" (get-universal-time) ex)
  (format t "~a" (format-color :red)))

(defun telegram-on-log-common (msg type-event color)
  (format t "~a:~a~%" (get-universal-time) msg)
  (format t "~a" (format-color :green)))

(loop
  (let ((result (read-line)))
    (when (string-equal (string-downcase result) *exit-command*)
      (exit 0))))

