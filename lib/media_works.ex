defmodule MediaWorks do
  use Application
  alias MediaWorks.Config
  @name __MODULE__

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Start our app specific config
    configure_remote_ordering_host

    Supervisor.start_link([], [strategy: :one_for_one, name: @name])
  end

  def configure_remote_ordering_host do
    {host, port} = parse_remote_ordering_url

    :ibrowse.set_max_sessions(host, port, Config.remote_ordering_sessions)
    :ibrowse.set_max_pipeline_size(host, port, Config.remote_ordering_pipeline)
  end

  defp parse_remote_ordering_url do
    URI.parse(Config.remote_ordering_url)
    |> case do
      %{host: host, port: port} ->
        {host |> String.to_charlist, port}
    end
  end

end
