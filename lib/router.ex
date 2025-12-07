defmodule Ice.Router do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(OpenApiSpex.Plug.PutApiSpec, module: Ice.ApiSpec)

  plug(:dispatch)

  forward("/users", to: Repo.User.Router)
  forward("/profiles", to: Repo.Profile.Router)

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  get "/api/openapi" do
    OpenApiSpex.Plug.RenderSpec.call(conn, [])
  end

  forward("/swaggerui", to: OpenApiSpex.Plug.SwaggerUI, init_opts: [path: "/api/openapi"])

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
