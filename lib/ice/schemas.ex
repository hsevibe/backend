defmodule Ice.Schemas do
  alias OpenApiSpex.Schema

  defmodule User do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "User",
      description: "A user",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "User ID"},
        created_at: %Schema{type: :string, format: :"date-time", description: "Created at"},
        login: %Schema{type: :string, description: "Login (phone or email)"},
        last_active_at: %Schema{
          type: :string,
          format: :"date-time",
          description: "Last active at"
        },
        is_banned: %Schema{type: :boolean, description: "Is banned"}
      },
      required: [:id, :created_at, :login, :is_banned]
    })
  end

  defmodule UserList do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UserList",
      description: "List of users",
      type: :array,
      items: User
    })
  end

  defmodule SignupUserRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "SignupUserRequest",
      description: "Request to signup a user",
      type: :object,
      properties: %{
        login: %Schema{type: :string, description: "Login (phone or email)"},
        password: %Schema{type: :string, description: "Password"}
      },
      required: [:login, :password]
    })
  end

  defmodule SigninUserRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "SigninUserRequest",
      description: "Request to signin a user",
      type: :object,
      properties: %{
        login: %Schema{type: :string, description: "Login (phone or email)"},
        pwd: %Schema{type: :string, description: "Password"}
      },
      required: [:login, :pwd]
    })
  end

  defmodule UpdateUserRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UpdateUserRequest",
      description: "Request to update a user",
      type: :object,
      properties: %{
        login: %Schema{type: :string, description: "Login (phone or email)"},
        password: %Schema{type: :string, description: "Password"}
      }
    })
  end

  defmodule Profile do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Profile",
      description: "A profile",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Profile ID"},
        created_at: %Schema{type: :string, format: :"date-time", description: "Created at"},
        user_id: %Schema{type: :string, description: "User ID"},
        name: %Schema{type: :string, description: "Name"},
        age: %Schema{type: :integer, description: "Age"},
        gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Gender"
        },
        about: %Schema{type: :string, description: "About (bio)"},
        avatar_url: %Schema{type: :string, description: "Avatar URL"},
        city: %Schema{type: :string, description: "City"},
        home_lat: %Schema{type: :number, format: :float, description: "Home latitude"},
        home_lng: %Schema{type: :number, format: :float, description: "Home longitude"},
        search_radius_km: %Schema{type: :integer, description: "Search radius in km"},
        preferred_partner_gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Preferred partner gender"
        },
        preferred_age_min: %Schema{type: :integer, description: "Preferred age min"},
        preferred_age_max: %Schema{type: :integer, description: "Preferred age max"},
        sport: %Schema{type: :string, description: "Sport"},
        badge: %Schema{type: :string, description: "Badge"}
      },
      required: [:id, :created_at, :user_id]
    })
  end

  defmodule ProfileList do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "ProfileList",
      description: "List of profiles",
      type: :array,
      items: Profile
    })
  end

  defmodule CreateProfileRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateProfileRequest",
      description: "Request to create a profile",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User ID"},
        name: %Schema{type: :string, description: "Name"},
        age: %Schema{type: :integer, description: "Age"},
        gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Gender"
        },
        about: %Schema{type: :string, description: "About (bio)"},
        avatar_url: %Schema{type: :string, description: "Avatar URL"},
        city: %Schema{type: :string, description: "City"},
        home_lat: %Schema{type: :number, format: :float, description: "Home latitude"},
        home_lng: %Schema{type: :number, format: :float, description: "Home longitude"},
        search_radius_km: %Schema{type: :integer, description: "Search radius in km"},
        preferred_partner_gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Preferred partner gender"
        },
        preferred_age_min: %Schema{type: :integer, description: "Preferred age min"},
        preferred_age_max: %Schema{type: :integer, description: "Preferred age max"},
        sport: %Schema{type: :string, description: "Sport"},
        badge: %Schema{type: :string, description: "Badge"}
      },
      required: [:user_id]
    })
  end

  defmodule UpdateProfileRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UpdateProfileRequest",
      description: "Request to update a profile",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User ID"},
        name: %Schema{type: :string, description: "Name"},
        age: %Schema{type: :integer, description: "Age"},
        gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Gender"
        },
        about: %Schema{type: :string, description: "About (bio)"},
        avatar_url: %Schema{type: :string, description: "Avatar URL"},
        city: %Schema{type: :string, description: "City"},
        home_lat: %Schema{type: :number, format: :float, description: "Home latitude"},
        home_lng: %Schema{type: :number, format: :float, description: "Home longitude"},
        search_radius_km: %Schema{type: :integer, description: "Search radius in km"},
        preferred_partner_gender: %Schema{
          type: :string,
          enum: ["male", "female", "other", "prefer_not"],
          description: "Preferred partner gender"
        },
        preferred_age_min: %Schema{type: :integer, description: "Preferred age min"},
        preferred_age_max: %Schema{type: :integer, description: "Preferred age max"},
        sport: %Schema{type: :string, description: "Sport"},
        badge: %Schema{type: :string, description: "Badge"}
      }
    })
  end

  defmodule Event do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Event",
      description: "An event",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Event ID"},
        created_at: %Schema{type: :string, format: :"date-time", description: "Created at"},
        user_id: %Schema{type: :string, description: "User ID"},
        date: %Schema{type: :string, format: :"date-time", description: "Event date"},
        lat: %Schema{type: :number, format: :float, description: "Latitude"},
        lon: %Schema{type: :number, format: :float, description: "Longitude"},
        title: %Schema{type: :string, description: "Event title"},
        level: %Schema{type: :string, description: "Event level"},
        info: %Schema{type: :string, description: "Event info"}
      },
      required: [:id, :created_at, :user_id, :date, :lat, :lon, :title, :level, :info]
    })
  end

  defmodule EventList do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "EventList",
      description: "List of events",
      type: :array,
      items: Event
    })
  end

  defmodule CreateEventRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateEventRequest",
      description: "Request to create an event",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User ID"},
        date: %Schema{type: :string, format: :"date-time", description: "Event date"},
        lat: %Schema{type: :number, format: :float, description: "Latitude"},
        lon: %Schema{type: :number, format: :float, description: "Longitude"},
        title: %Schema{type: :string, description: "Event title"},
        level: %Schema{type: :string, description: "Event level"},
        info: %Schema{type: :string, description: "Event info"}
      },
      required: [:user_id, :date, :lat, :lon, :title, :level, :info]
    })
  end

  defmodule UpdateEventRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UpdateEventRequest",
      description: "Request to update an event",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User ID"},
        date: %Schema{type: :string, format: :"date-time", description: "Event date"},
        lat: %Schema{type: :number, format: :float, description: "Latitude"},
        lon: %Schema{type: :number, format: :float, description: "Longitude"},
        title: %Schema{type: :string, description: "Event title"},
        level: %Schema{type: :string, description: "Event level"},
        info: %Schema{type: :string, description: "Event info"}
      }
    })
  end

  defmodule Training do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Training",
      description: "A training",
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Training ID"},
        created_at: %Schema{type: :string, format: :"date-time", description: "Created at"},
        title: %Schema{type: :string, description: "Training title"},
        info: %Schema{type: :string, description: "Training info"},
        level: %Schema{type: :string, description: "Training level"},
        count: %Schema{type: :integer, description: "Training count"},
        type: %Schema{type: :string, description: "Training type"}
      },
      required: [:id, :created_at, :title, :info, :level, :count, :type]
    })
  end

  defmodule TrainingList do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "TrainingList",
      description: "List of trainings",
      type: :array,
      items: Training
    })
  end

  defmodule CreateTrainingRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "CreateTrainingRequest",
      description: "Request to create a training",
      type: :object,
      properties: %{
        title: %Schema{type: :string, description: "Training title"},
        info: %Schema{type: :string, description: "Training info"},
        level: %Schema{type: :string, description: "Training level"},
        count: %Schema{type: :integer, description: "Training count"},
        type: %Schema{type: :string, description: "Training type"}
      },
      required: [:title, :info, :level, :count, :type]
    })
  end

  defmodule UpdateTrainingRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UpdateTrainingRequest",
      description: "Request to update a training",
      type: :object,
      properties: %{
        title: %Schema{type: :string, description: "Training title"},
        info: %Schema{type: :string, description: "Training info"},
        level: %Schema{type: :string, description: "Training level"},
        count: %Schema{type: :integer, description: "Training count"},
        type: %Schema{type: :string, description: "Training type"}
      }
    })
  end

  defmodule ErrorResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "ErrorResponse",
      description: "Error response",
      type: :object,
      properties: %{
        error: %Schema{type: :string}
      }
    })
  end
end
