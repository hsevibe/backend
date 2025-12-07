defmodule Ice.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi, Server, Operation, PathItem}

  alias Ice.Schemas.{
    User,
    UserList,
    SignupUserRequest,
    SigninUserRequest,
    UpdateUserRequest,
    ErrorResponse
  }

  @behaviour OpenApiSpex.OpenApi

  @impl OpenApiSpex.OpenApi
  def spec do
    %OpenApi{
      servers: [
        %Server{url: "http://localhost:80"}
      ],
      info: %Info{
        title: "Ice API",
        version: "1.0.0",
        description: "API for Ice application"
      },
      paths: %{
        "/users" => %PathItem{
          get: %Operation{
            tags: ["users"],
            summary: "List users",
            description: "List all users",
            operationId: "UserController.index",
            responses: %{
              200 => Operation.response("User List", "application/json", UserList)
            }
          }
        },
        "/users/signup" => %PathItem{
          post: %Operation{
            tags: ["users"],
            summary: "Signup user",
            description: "Signup a new user",
            operationId: "UserController.signup",
            requestBody:
              Operation.request_body("User attributes", "application/json", SignupUserRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("User", "application/json", User),
              400 => Operation.response("Bad Request", "application/json", ErrorResponse)
            }
          }
        },
        "/users/signin" => %PathItem{
          post: %Operation{
            tags: ["users"],
            summary: "Signin user",
            description: "Signin a user",
            operationId: "UserController.signin",
            requestBody:
              Operation.request_body("Signin credentials", "application/json", SigninUserRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("User", "application/json", User),
              401 => Operation.response("Unauthorized", "application/json", ErrorResponse),
              400 => Operation.response("Bad Request", "application/json", ErrorResponse)
            }
          }
        },
        "/users/{user_id}" => %PathItem{
          get: %Operation{
            tags: ["users"],
            summary: "Get user",
            description: "Get a user by ID",
            operationId: "UserController.show",
            parameters: [
              Operation.parameter(:user_id, :path, :string, "User ID", required: true)
            ],
            responses: %{
              200 => Operation.response("User", "application/json", User),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          put: %Operation{
            tags: ["users"],
            summary: "Update user",
            description: "Update an existing user",
            operationId: "UserController.update",
            parameters: [
              Operation.parameter(:user_id, :path, :string, "User ID", required: true)
            ],
            requestBody:
              Operation.request_body("User attributes", "application/json", UpdateUserRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("User", "application/json", User),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          delete: %Operation{
            tags: ["users"],
            summary: "Delete user",
            description: "Delete a user by ID",
            operationId: "UserController.delete",
            parameters: [
              Operation.parameter(:user_id, :path, :string, "User ID", required: true)
            ],
            responses: %{
              204 => Operation.response("No Content", "application/json", nil),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          }
        }
      }
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
