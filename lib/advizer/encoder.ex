defimpl Jason.Encoder, for: Advizer.Quotations.Simulation do
  def encode(struct, opts) do
    Enum.reduce(Map.from_struct(struct), %{}, fn
      {_k, %Ecto.Association.NotLoaded{}}, acc -> acc
      {:__meta__, _}, acc -> acc
      {k, v}, acc -> Map.put(acc, encode_key(k), v)
    end)
    |> Jason.Encode.map(opts)
  end

  defp encode_key(atom) do
    atom
    |> Atom.to_string()
    |> Recase.to_camel()
  end
end
