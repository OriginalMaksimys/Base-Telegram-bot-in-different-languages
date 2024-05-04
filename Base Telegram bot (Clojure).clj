(require '[clj-telegram-bot.core :as tg])

(def exit-command "exit")

(def telegram
  (tg/create-bot
   {:token ""
    :clear-updates-on-start true
    :white-list-users []
    :admins []
    :bot-id 0}))

(defn telegram-on-log-error [ex id]
  (binding [*out* *err*]
    (println (str (java.time.LocalDateTime/now) ":" ex))))

(defn telegram-on-log-common [msg type-event color]
  (println (str (java.time.LocalDateTime/now) ":" msg)))

(tg/add-listener telegram :log-common telegram-on-log-common)
(tg/add-listener telegram :log-error telegram-on-log-error)

(tg/start telegram)

(while true
  (let [result (read-line)]
    (when (= (.toLowerCase result) exit-command)
      (System/exit 0))))

