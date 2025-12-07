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
