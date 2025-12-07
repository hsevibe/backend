defmodule Repo.Training.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @repo Repo.Domain

  get "" do
    case @repo.list_trainings() do
      {:ok, trainings} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(trainings))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  get "/:training_id" do
    case @repo.get_training(training_id) do
      {:ok, training} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(training))

      {:error, :training_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Training not found"}))

      {:error, :internal_error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{error: "Internal server error"}))
    end
  end

  post "" do
    attrs = conn.body_params

    case @repo.create_training(attrs) do
      {:ok, training} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(201, Jason.encode!(training))

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

  put "/:training_id" do
    attrs = conn.body_params

    case @repo.update_training(training_id, attrs) do
      {:ok, training} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(training))

      {:error, :training_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Training not found"}))

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

  delete "/:training_id" do
    case @repo.delete_training(training_id) do
      :ok ->
        send_resp(conn, 204, "")

      {:error, :training_not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Training not found"}))

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
