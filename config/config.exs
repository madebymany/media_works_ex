use Mix.Config

config :media_works,
  api_client: MediaWorks.HTTP,
  remote_ordering_sessions: 100,
  remote_ordering_pipeline: 100,
  remote_ordering_url: "https://remote-ordering-dot-mw-central.appspot.com/",
  api_url: "https://mw-central.appspot.com/"

import_config "#{Mix.env}.exs"
