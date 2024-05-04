defmodule PRTelegramBot.Core do
  use Application

  def start(_type, _args) do
    children = [
      {PRTelegramBot.Supervisor, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule PRTelegramBot.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {PRTelegramBot.Bot, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule PRTelegramBot.Bot do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    token = Keyword.get(opts, :token, "")
    clear_updates_on_start = Keyword.get(opts, :clear_updates_on_start, true)
    white_list_users = Keyword.get(opts, :white_list_users, [])
    admins = Keyword.get(opts, :admins, [])
    bot_id = Keyword.get(opts, :bot_id, 0)

    state = %{
      token: token,
      clear_updates_on_start: clear_updates_on_start,
      white_list_users: white_list_users,
      admins: admins,
      bot_id: bot_id
    }

    {:ok, state}
  end

  def handle_info({:log_common, msg, type_event, color}, state) do
    IO.ANSI.format([:green, "#{DateTime.now()}: #{msg}"])
    |> IO.puts()

    {:noreply, state}
  end

  def handle_info({:log_error, exception, id}, state) do
    IO.ANSI.format([:red, "#{DateTime.now()}: #{Exception.message(exception)}"])
    |> IO.puts()

    {:noreply, state}
  end

  def handle_info({:start}, state) do
    # Start the bot
    {:noreply, state}
  end
end

defmodule Main do
  @exit_command "exit"

  def main do
    bot = start_bot()

    loop(bot)
  end

  defp start_bot do
    bot = start_link_bot([
      token: "",
      clear_updates_on_start: true,
      white_list_users: [],
      admins: [],
      bot_id: 0
    ])

    GenServer.cast(bot, {:start})
    bot
  end

  defp start_link_bot(opts) do
    {:ok, pid} = PRTelegramBot.Bot.start_link(opts)
    pid
  end

  defp loop(bot) do
    case IO.gets("> ") do
      {@exit_command <> _rest} ->
        System.halt(0)

      _ ->
        loop(bot)
    end
  end
end

Main.main()

