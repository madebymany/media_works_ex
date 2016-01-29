use Mix.Config

config :media_works,
  mw_api: MediaWorks.HTTP

import_config "#{Mix.env}.exs"
