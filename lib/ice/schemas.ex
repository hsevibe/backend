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
        first_name: %Schema{type: :string, description: "First name"},
        last_name: %Schema{type: :string, description: "Last name"},
        email: %Schema{type: :string, description: "Email"},
        telegram: %Schema{type: :string, description: "Telegram"},
        role: %Schema{
          type: :string,
          enum: ["mentor", "normie"],
          description: "User role"
        },
        pfp: %Schema{type: :string, description: "Profile picture"}
      },
      required: [:id, :first_name, :last_name, :email, :telegram, :role, :pfp]
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
        first_name: %Schema{type: :string, description: "First name"},
        last_name: %Schema{type: :string, description: "Last name"},
        email: %Schema{type: :string, description: "Email"},
        telegram: %Schema{type: :string, description: "Telegram"},
        password: %Schema{type: :string, description: "Password"},
        pfp: %Schema{type: :string, description: "Profile picture"},
        role: %Schema{
          type: :string,
          enum: ["mentor", "normie"],
          description: "User role",
          default: "normie"
        }
      },
      required: [:first_name, :last_name, :email, :telegram, :password, :pfp]
    })
  end

  defmodule SigninUserRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "SigninUserRequest",
      description: "Request to signin a user",
      type: :object,
      properties: %{
        email: %Schema{type: :string, description: "Email"},
        pwd: %Schema{type: :string, description: "Password"}
      },
      required: [:email, :pwd]
    })
  end

  defmodule UpdateUserRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "UpdateUserRequest",
      description: "Request to update a user",
      type: :object,
      properties: %{
        first_name: %Schema{type: :string, description: "First name"},
        last_name: %Schema{type: :string, description: "Last name"},
        email: %Schema{type: :string, description: "Email"},
        telegram: %Schema{type: :string, description: "Telegram"},
        password: %Schema{type: :string, description: "Password"},
        pfp: %Schema{type: :string, description: "Profile picture"},
        role: %Schema{
          type: :string,
          enum: ["mentor", "normie"],
          description: "User role"
        }
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
