defmodule Repo.Domain do
  use Ash.Domain
  require Ash.Query

  resources do
    resource Repo.User
    resource Repo.Profile
    resource Repo.Event
  end

  @user Repo.User
  @profile Repo.Profile
  @event Repo.Event

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

  def list_profiles do
    case Ash.read(@profile) do
      {:ok, profiles} -> {:ok, profiles}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def get_profile(profile_id) do
    case @profile |> Ash.Query.filter(id: profile_id) |> Ash.read() do
      {:ok, [profile]} -> {:ok, profile}
      {:ok, []} -> {:error, :profile_not_found}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def get_profile_by_user_id(user_id) do
    case @profile |> Ash.Query.filter(user_id: user_id) |> Ash.read() do
      {:ok, [profile]} -> {:ok, profile}
      {:ok, []} -> {:error, :profile_not_found}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def create_profile(attrs) do
    case @profile |> Ash.Changeset.for_create(:create, attrs) |> Ash.create() do
      {:ok, profile} ->
        {:ok, profile}

      {:error, %Ash.Error.Invalid{}} ->
        {:error, :validation_error}

      {:error, _} ->
        {:error, :internal_error}
    end
  end

  def update_profile(profile_id, attrs) do
    case @profile |> Ash.get(profile_id) do
      {:ok, profile} ->
        case profile |> Ash.Changeset.for_update(:update, attrs) |> Ash.update() do
          {:ok, profile} -> {:ok, profile}
          {:error, %Ash.Error.Invalid{}} -> {:error, :validation_error}
          {:error, _} -> {:error, :internal_error}
        end

      {:error, %Ash.Error.Query.NotFound{}} ->
        {:error, :profile_not_found}

      {:error, _} ->
        {:error, :internal_error}
    end
  end

  def delete_profile(profile_id) do
    case @profile |> Ash.get(profile_id) do
      {:ok, nil} ->
        {:error, :profile_not_found}

      {:ok, profile} ->
        case profile |> Ash.destroy() do
          :ok ->
            :ok

          {:error, %Ash.Error.Query.NotFound{}} ->
            {:error, :profile_not_found}
        end

      {:error, _} ->
        {:error, :profile_not_found}
    end
  end

  def list_events do
    case Ash.read(@event) do
      {:ok, events} -> {:ok, events}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def get_event(event_id) do
    case @event |> Ash.Query.filter(id: event_id) |> Ash.read() do
      {:ok, [event]} -> {:ok, event}
      {:ok, []} -> {:error, :event_not_found}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def create_event(attrs) do
    case @event |> Ash.Changeset.for_create(:create, attrs) |> Ash.create() do
      {:ok, event} ->
        {:ok, event}

      {:error, %Ash.Error.Invalid{}} ->
        {:error, :validation_error}

      {:error, _} ->
        {:error, :internal_error}
    end
  end

  def update_event(event_id, attrs) do
    case @event |> Ash.get(event_id) do
      {:ok, event} ->
        case event |> Ash.Changeset.for_update(:update, attrs) |> Ash.update() do
          {:ok, event} -> {:ok, event}
          {:error, %Ash.Error.Invalid{}} -> {:error, :validation_error}
          {:error, _} -> {:error, :internal_error}
        end

      {:error, %Ash.Error.Query.NotFound{}} ->
        {:error, :event_not_found}

      {:error, _} ->
        {:error, :internal_error}
    end
  end

  def get_events_by_user_id(user_id) do
    case @event |> Ash.Query.filter(user_id: user_id) |> Ash.read() do
      {:ok, events} -> {:ok, events}
      {:error, _} -> {:error, :internal_error}
    end
  end

  def delete_event(event_id) do
    case @event |> Ash.get(event_id) do
      {:ok, event} ->
        case event |> Ash.destroy() do
          :ok -> :ok
          {:error, _} -> {:error, :internal_error}
        end

      {:error, %Ash.Error.Query.NotFound{}} ->
        {:error, :event_not_found}

      {:error, _} ->
        {:error, :internal_error}
    end
  end
end
