defmodule Seraphin.Quoter do
  require Logger

  @api_key Application.compile_env!(:advizer, :seraphin)[:api_key]
  @endpoint "https://staging-gtw.seraphin.be/quotes/professional-liability"

  def send_request(simulation) do
    payload = Jason.encode!(simulation)

    %HTTPoison.Request{
      method: :post,
      headers: [
        {"Content-Type", "application/json"},
        {"X-Api-Key", @api_key}
      ],
      url: @endpoint,
      body: payload
    }
    |> HTTPoison.request()
    |> decode_response()
  end

  def decode_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    {:ok, results} = Jason.decode(body)

    results
  end

  def decode_response({:error, error}) do
    Logger.error(error)
  end
end
