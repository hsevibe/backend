defmodule Repo.Event.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @repo Repo.Domain

  get "" do
    case @repo.list_events() do
      {:ok, events} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(events))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/:event_id" do
    case @repo.get_event(event_id) do
      {:ok, event} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(event))

      {:error, :event_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Event not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/by-user/:user_id" do
    case @repo.get_events_by_user_id(user_id) do
      {:ok, events} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(events))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  post "" do
    attrs = conn.body_params

    case @repo.create_event(attrs) do
      {:ok, event} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(event))

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

  put "/:event_id" do
    attrs = conn.body_params

    case @repo.update_event(event_id, attrs) do
      {:ok, event} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(event))

      {:error, :event_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Event not found"}))

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

  delete "/:event_id" do
    case @repo.delete_event(event_id) do
      :ok ->
        send_resp(conn, 204, "")

      {:error, :event_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Event not found"}))

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
