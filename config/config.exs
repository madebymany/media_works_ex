use Mix.Config

config :media_works,
  api_client: MediaWorks.HTTP

import_config "#{Mix.env}.exs"
