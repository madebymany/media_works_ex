# Media Works Ex

A simple wrapper around the MW:Central API.

## Installation

1. Add media_works to your list of dependencies in `mix.exs`:

```
  def deps do
    [{:media_works, "~> 0.0.1"}]
  end
```

2. Ensure media_works is started before your application:

```
  def application do
    [applications: [:media_works]]
  end
```

3. Ensure you have the relevant media_works config options (`username`, `password`, `api_key`)

```
config :media_works,
  username: "blah",
  password: "blah",
  api_key: "blah-blah"
```

By default we look for these config options and fall back to environment variables if they're not set:

```
MW_USERNAME
MW_PASSWORD
MW_API_KEY
```

## Todo

[] Documentation
[] Tests