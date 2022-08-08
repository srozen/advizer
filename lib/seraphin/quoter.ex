defmodule Seraphin.Quoter do
  require Logger

  alias Advizer.Quotations.Simulation

  @api_key Application.compile_env!(:advizer, :seraphin)[:api_key]
  @endpoint Application.compile_env!(:advizer, :seraphin)[:endpoint]

  @spec get_quote(%Simulation{}) :: {:error, binary} | {:ok, %{data: %{}}}
  def get_quote(simulation) do
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

  @spec decode_response({:error, any} | {:ok, HTTPoison.Response.t()}) ::
          {:ok, %{}} | {:error, binary()}
  def decode_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Jason.decode(body, keys: fn key -> key |> Recase.to_snake() |> String.to_atom() end)
  end

  def decode_response({:error, error}) do
    Logger.error(error)
    {:error, error}
  end
end
