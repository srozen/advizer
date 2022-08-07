defimpl Phoenix.Param, for: Advizer.Quotations.Simulation do
  def to_param(%{uuid: uuid}), do: uuid
end
