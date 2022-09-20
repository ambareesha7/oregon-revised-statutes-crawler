defmodule Crawlers.Parsers.ORS do
  @spec parse(atom | %{:body => binary, optional(any) => any}) :: Crawly.ParsedItem.t()
  def parse(response) do
    {:ok, document} = Floki.parse_document(response.body)

    headings =
      document
      |> Floki.find("tbody[id^=titl]")
      |> Enum.map(fn e -> %{name: Floki.text(e)} end)

    %Elixir.Crawly.ParsedItem{items: headings, requests: []}
  end

  defp id(elem) do
    elem
    |> Floki.attribute("id")
    |> List.first("")
  end
end
