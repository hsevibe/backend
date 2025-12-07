defmodule Repo.Profile do
  use Ash.Resource,
    domain: Repo.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshJason.Resource]

  postgres do
    table "profiles"
    repo Ice.Repo
  end

  actions do
    defaults [:read, :destroy, :update, :create]

    default_accept [
      :user_id,
      :name,
      :age,
      :gender,
      :about,
      :avatar_url,
      :city,
      :home_lat,
      :home_lng,
      :search_radius_km,
      :preferred_partner_gender,
      :preferred_age_min,
      :preferred_age_max,
      :sport,
      :badge
    ]
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :created_at

    attribute :user_id, :uuid do
      allow_nil? false
      public? true
    end

    attribute :name, :string do
      allow_nil? true
      public? true
    end

    attribute :age, :integer do
      allow_nil? true
      public? true
    end

    attribute :gender, :string do
      allow_nil? true
      public? true
    end

    attribute :about, :string do
      allow_nil? true
      public? true
    end

    attribute :avatar_url, :string do
      allow_nil? true
      public? true
    end

    attribute :city, :string do
      allow_nil? true
      public? true
    end

    attribute :home_lat, :float do
      allow_nil? true
      public? true
    end

    attribute :home_lng, :float do
      allow_nil? true
      public? true
    end

    attribute :search_radius_km, :integer do
      allow_nil? true
      public? true
    end

    attribute :preferred_partner_gender, :string do
      allow_nil? true
      public? true
    end

    attribute :preferred_age_min, :integer do
      allow_nil? true
      public? true
    end

    attribute :preferred_age_max, :integer do
      allow_nil? true
      public? true
    end

    attribute :sport, :string do
      allow_nil? true
      public? true
    end

    attribute :badge, :string do
      allow_nil? true
      public? true
    end
  end

  identities do
    identity :unique_user_id, [:user_id]
  end
end
