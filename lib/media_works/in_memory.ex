defmodule MediaWorks.InMemory do
  def post("/api/data/export_store") do
    %{body: %{result: [], code: 2}, status_code: 200}
  end

  def post("/api/data/export_store/1") do
    %{body: %{result: %{}}, status_code: 200}
  end

  def post("/api/data/export_store/2") do
    %{body: %{desc: "Hello World"}, status_code: 404}
  end

  def post("/api/data/export_orders/1") do
  end

  def post("/api/data/export_orders/2") do
    %{body: %{desc: "Could not parse JSON response"}, status_code: 404}
  end

  def post("/api/remote_ordering/1", [body: "GoodBody"]) do
  end

  def post("/api/remote_ordering/1", [body: "BadBody"]) do
  end

  def post("/api/remote_ordering/2", [body: "<Order></Order>"]) do
    %{body: %{code: 1008, desc: "Invalid XML received"}, status_code: 200}
  end

  def post("/api/remote_ordering/2", [body: "BadBody"]) do
    %{body: %{code: 1007, desc: "Error parsing XML"}, status_code: 200}
  end
end
