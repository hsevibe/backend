# Agent Guidelines for HSE Backend

## Commands
- **Build**: `mix compile`
- **Test all**: `mix test`
- **Test single**: `mix test path/to/test_file.exs:line_number`
- **Format**: `mix format`
- **Setup**: `mix ash.setup`
- **Deps**: `mix deps.get`

## Code Style & Patterns
- **Framework**: Ash 3.0 + AshPostgres + AshJason for resources
- **API**: OpenAPI Spex for docs, Plug.Router with forward() for routing
- **Auth**: Argon2 for password hashing via Utils.Argon
- **Modules**: PascalCase (Repo.User), Functions/Variables: snake_case
- **Error Handling**: Pattern matching with `case`/`with`, return `{:ok, result}` or `{:error, reason}`
- **Resources**: Ash.Resource with actions, attributes (public?/allow_nil?), identities
- **Domains**: Ash.Domain for business logic, CRUD functions return {:ok, result} or {:error, error}
- **Routers**: Plug.Router with plug(:match/:dispatch), JSON responses via Jason
- **Schemas**: OpenAPI schemas in Ice.Schemas module, manual spec definition
- **Formatting**: Spark.Formatter with Ash plugins, imports after `use` statements
- **Configuration**: `Application.compile_env/3` for secrets, Jason for JSON ops

## Best Practices
- **BEFORE EDITING**: Fetch latest Ash/OpenAPI Spex docs via webfetch tool
- Generate OpenAPI specs for all endpoints, use Ash actions for data ops
- Implement meaningful error messages, follow existing module structure
- Use identities for unique constraints, hash passwords before storage
- Return proper HTTP status codes, pattern match on domain function results
