defmodule Ahfi.Notifies.Slack do
  @base_url "https://hooks.slack.com/services/"

  @http Application.get_env(:ahfi, :slack)[:http_client]
  def send!(msg) do
    content = Poison.encode!(%{"text" => msg})
    response = @http.post!(url(), content, [{"Content-Type", "application/json"}])
    IO.puts(inspect response)
    result = response.body
  end

  @hook Application.get_env(:ahfi, :slack)[:hook]
  def url() do
    @base_url <> @hook
  end
end
