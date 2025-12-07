import Config

config :ice, Ice.Repo,
  database: ":memory:",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :ash, policies: [show_policy_breakdowns?: true], disable_async?: true
# config :ice, :ash_data_layer, AshPostgres.DataLayer
