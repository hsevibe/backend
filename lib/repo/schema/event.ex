defmodule Repo.Event do
  use Ash.Resource,
    domain: Repo.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJason.Resource]

  postgres do
    table "events"
    repo Ice.Repo
  end

  actions do
    defaults [:read, :destroy, :update, :create]

    default_accept [
      :user_id,
      :date,
      :lat,
      :lon,
      :title,
      :level,
      :info
    ]
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :created_at

    attribute :user_id, :uuid do
      allow_nil? false
      public? true
    end

    attribute :date, :utc_datetime do
      allow_nil? false
      public? true
    end

    attribute :lat, :float do
      allow_nil? false
      public? true
    end

    attribute :lon, :float do
      allow_nil? false
      public? true
    end

    attribute :title, :string do
      allow_nil? false
      public? true
    end

    attribute :level, :string do
      allow_nil? false
      public? true
    end

    attribute :info, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    belongs_to :user, Repo.User do
      attribute_type :uuid
      attribute_public? true
    end
  end
end
