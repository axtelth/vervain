defmodule Vervain do
  use Application

  @impl true
  def start(_type, _args) do
    Vervain.Application.start_link(name: Vervain.Supervisor)
  end
end
