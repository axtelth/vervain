defmodule Vervain.Vk do
  @token Application.fetch_env!(:vervain, :token)
  @v 5.131

  defmodule Vervain.Vk.Base do
    use HTTPoison.Base
    def process_request_url(method), do: "https://api.vk.com/method/" <> method
    def process_response_body(body), do: body |> Jason.decode!()
  end

  defmacro invoke(method, params \\ %{}) do
    quote do
      Vervain.Vk.Base.get!(
        unquote(method),
        [],
        params:
          Map.merge(
            %{
              access_token: unquote(@token),
              v: unquote(@v)
            },
            unquote(params)
          )
      ).body
    end
  end
end
