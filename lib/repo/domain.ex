defmodule Repo.Domain do
  use Ash.Domain
  require Ash.Query

  resources do
    resource Repo.User
  end

  @user Repo.User

  def list_users do
    case Ash.read(@user) do
      {:ok, users} -> {:ok, users}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def get_user(user_id) do
    case @user |> Ash.Query.filter(id: user_id) |> Ash.read() do
      {:ok, [user]} -> {:ok, user}
      {:ok, []} -> {:error, :user_not_found}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def signup_user(attrs) do
    case @user |> Ash.Changeset.for_create(:signup, attrs) |> Ash.create() do
      {:ok, user} -> {:ok, user}
      {:error, %Ash.Error.Invalid{}} -> {:error, :validation_error}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def signin_user(attrs) do
    case @user |> Ash.ActionInput.for_action(:signin, attrs) |> Ash.run_action() do
      {:ok, user} -> {:ok, user}
      {:error, %Ash.Error.Forbidden{}} -> {:error, :invalid_credentials}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def update_user(user_id, attrs) do
    case @user |> Ash.get(user_id) do
      {:ok, user} ->
        case user |> Ash.Changeset.for_update(:update, attrs) |> Ash.update() do
          {:ok, user} -> {:ok, user}
          {:error, %Ash.Error.Invalid{}} -> {:error, :validation_error}
          {:error, _} -> {:error, :internal_error}
        end

      {:error, %Ash.Error.Query.NotFound{}} ->
        {:error, :user_not_found}

      {:error, _} ->
        {:error, :internal_error}
    end
  end

  def delete_user(user_id) do
    case @user |> Ash.get(user_id) do
      {:ok, user} ->
        case user |> Ash.destroy() do
          :ok -> :ok
          {:error, _} -> {:error, :internal_error}
        end

      {:error, %Ash.Error.Query.NotFound{}} ->
        {:error, :user_not_found}

      {:error, _} ->
        {:error, :internal_error}
    end
  end
end
