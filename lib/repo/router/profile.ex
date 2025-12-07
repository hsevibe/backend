defmodule Repo.Profile.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @repo Repo.Domain

  get "" do
    case @repo.list_profiles() do
      {:ok, profiles} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(profiles))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/:profile_id" do
    case @repo.get_profile(profile_id) do
      {:ok, profile} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(profile))

      {:error, :profile_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Profile not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/by-user/:user_id" do
    case @repo.get_profile_by_user_id(user_id) do
      {:ok, profile} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(profile))

      {:error, :profile_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Profile not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  post "" do
    attrs = conn.body_params

    case @repo.create_profile(attrs) do
      {:ok, profile} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(profile))

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

  put "/:profile_id" do
    attrs = conn.body_params

    case @repo.update_profile(profile_id, attrs) do
      {:ok, profile} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(profile))

      {:error, :profile_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Profile not found"}))

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

  delete "/:profile_id" do
    case @repo.delete_profile(profile_id) do
      :ok ->
        send_resp(conn, 204, "")

      {:error, :profile_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Profile not found"}))

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
