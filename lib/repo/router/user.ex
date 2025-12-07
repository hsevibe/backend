defmodule Repo.User.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @repo Repo.Domain

  get "" do
    case @repo.list_users() do
      {:ok, users} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(users))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/:user_id" do
    case @repo.get_user(user_id) do
      {:ok, user} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(user))

      {:error, :user_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "User not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  post "/signup" do
    attrs = conn.body_params

    case @repo.signup_user(attrs) do
      {:ok, user} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(user))

      {:error, :validation_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{error: "Validation error"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  post "/signin" do
    attrs = conn.body_params

    case @repo.signin_user(attrs) do
      {:ok, user} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(user))

      {:error, :invalid_credentials} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: "Invalid credentials"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  put "/:user_id" do
    attrs = conn.body_params

    case @repo.update_user(user_id, attrs) do
      {:ok, user} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(user))

      {:error, :user_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "User not found"}))

      {:error, :validation_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{error: "Validation error"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  delete "/:user_id" do
    case @repo.delete_user(user_id) do
      :ok ->
        send_resp(conn, 204, "")

      {:error, :user_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "User not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{error: "Not Found"}))
  end
end
