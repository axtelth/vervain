defmodule Vervain.Application do
  @moduledoc false

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, [], args)
  end

  def init(_args) do
    # token = Application.fetch_env!(:vervain, :token)
    # v = Application.fetch_env!(:vervain, :v)
    children = [
      {Vervain.Bot, name: Vervain.Bot}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
