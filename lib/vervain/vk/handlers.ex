defmodule Vervain.Handlers do
  @moduledoc """
  Хендлеры для ивентов вк
  """

  require Vervain.Vk

  def handle_event([
        4,
        msg_id,
        _flags,
        peer_id,
        _timestamp,
        _peer_name,
        text,
        _additional
      ]) do
    case text |> String.downcase() do
      "мяу" ->
        Vervain.Vk.invoke("messages.send", %{
          peer_id: peer_id,
          message: "мур",
          reply_to: msg_id,
          random_id: Enum.random(-2_147_483_648..2_147_483_647)
        })
        |> IO.inspect()

      _ ->
        nil
    end
  end

  def handle_event(_), do: nil
end
