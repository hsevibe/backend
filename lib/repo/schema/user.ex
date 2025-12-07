defmodule Repo.User do
  alias Ash.Error.Unknown
  alias Ash.Error.Forbidden

  use Ash.Resource,
    domain: Repo.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJason.Resource]

  import Utils.Argon
  require Ash.Query

  postgres do
    table "users"
    repo Ice.Repo
  end

  actions do
    defaults [:read, :destroy, :update]

    create :signup do
      change fn changeset, _ ->
        pwd = Ash.Changeset.get_attribute(changeset, :password)

        changeset =
          if pwd do
            Ash.Changeset.change_attribute(changeset, :password, encode_pwd(pwd))
          else
            changeset
          end

        Ash.Changeset.change_attribute(changeset, :last_active_at, DateTime.utc_now())
      end
    end

    action :signin do
      returns :term
      argument :login, :string, allow_nil?: false
      argument :pwd, :string, allow_nil?: false

      run fn changeset, _ ->
        login = Ash.Changeset.get_argument(changeset, :login)
        pwd = Ash.Changeset.get_argument(changeset, :pwd)

        case Repo.User
             |> Ash.Query.filter(login: login)
             |> Ash.read() do
          {:ok, [user]} ->
            if verify_pwd(pwd, user.password) do
              {:ok, user}
            else
              {:error, Forbidden.exception()}
            end

          {:ok, []} ->
            {:error, Forbidden.exception()}

          {:error, _err} ->
            {:error, Unknown.exception()}
        end
      end
    end

    default_accept [:login, :password]
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :created_at

    attribute :login, :string do
      allow_nil? false
      public? true
    end

    attribute :password, :string do
      allow_nil? false
      public? false
    end

    attribute :last_active_at, :utc_datetime do
      allow_nil? true
      public? true
    end

    attribute :is_banned, :boolean do
      default false
      public? true
    end
  end

  identities do
    identity :unique_login, [:login]
  end
end
