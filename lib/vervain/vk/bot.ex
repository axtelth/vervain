defmodule Vervain.Bot do
  require Vervain.Vk
  require Logger

  # @token Application.fetch_env!(:vervain, :token)
  # @v Application.fetch_env!(:vervain, :v)

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: :infinity
    }
  end

  def start(_) do
    Logger.info("Started")
    res = update()
    check(res)
  end

  def check(data) do
    params =
      URI.encode_query(%{
        act: "a_check",
        wait: 25,
        mode: 10,
        key: data["key"],
        ts: data["ts"]
      })

    res =
      HTTPoison.post!(
        "https://" <> data["server"],
        params,
        %{"Content-Type" => "application/x-www-form-urlencoded"},
        recv_timeout: 30_000
      ).body
      |> Jason.decode!()

    Logger.info("Got event: #{inspect(res)}")

    case res do
      %{"updates" => updates} ->
        Logger.info("Updates: #{inspect(updates)}")

        Enum.each(updates, fn update ->
          Task.start(fn ->
            Vervain.Handlers.handle_event(update)
          end)
        end)

        check(%{data | "ts" => res["ts"]})

      _ ->
        case res["failed"] do
          1 -> %{data | "ts" => res["ts"]} |> check()
          a -> IO.inspect(a)
        end
    end
  end

  def update() do
    Logger.info("Updated lp")

    %{"response" => params} =
      Vervain.Vk.invoke(
        "messages.getLongPollServer",
        %{}
        # %{access_token: @token, v: @v}
      )

    params
  end
end
