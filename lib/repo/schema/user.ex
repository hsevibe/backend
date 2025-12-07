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

        if pwd do
          Ash.Changeset.change_attribute(changeset, :password, encode_pwd(pwd))
        else
          changeset
        end
      end
    end

    action :signin do
      returns :term
      argument :email, :string, allow_nil?: false
      argument :pwd, :string, allow_nil?: false

      run fn changeset, _ ->
        email = Ash.Changeset.get_argument(changeset, :email)
        pwd = Ash.Changeset.get_argument(changeset, :pwd)

        case Repo.User
             |> Ash.Query.filter(email: email)
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

    default_accept [:first_name, :last_name, :email, :telegram, :role, :password, :pfp]
  end

  attributes do
    uuid_primary_key :id

    attribute :first_name, :string do
      allow_nil? false
      public? true
    end

    attribute :last_name, :string do
      allow_nil? false
      public? true
    end

    attribute :email, :string do
      allow_nil? false
      public? true
    end

    attribute :telegram, :string do
      allow_nil? false
      public? true
    end

    attribute :password, :string do
      allow_nil? false
      public? false
    end

    attribute :pfp, :string do
      allow_nil? false
      public? true
    end

    attribute :role, :atom do
      default :normie
      public? true
      constraints one_of: [:mentor, :normie]
    end
  end

  identities do
    identity :unique_email, [:email]
  end
end
