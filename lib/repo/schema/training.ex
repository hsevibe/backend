defmodule Repo.Training do
  use Ash.Resource,
    domain: Repo.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJason.Resource]

  postgres do
    table "trainings"
    repo Ice.Repo
  end

  actions do
    defaults [:read, :destroy, :update, :create]

    default_accept [
      :title,
      :info,
      :level,
      :count,
      :type
    ]
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :created_at

    attribute :title, :string do
      allow_nil? false
      public? true
    end

    attribute :info, :string do
      allow_nil? false
      public? true
    end

    attribute :level, :string do
      allow_nil? false
      public? true
    end

    attribute :count, :integer do
      allow_nil? false
      public? true
    end

    attribute :type, :string do
      allow_nil? false
      public? true
    end
  end
end
