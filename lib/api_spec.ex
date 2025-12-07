defmodule Ice.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi, Server, Operation, PathItem}

  alias Ice.Schemas.{
    User,
    UserList,
    SignupUserRequest,
    SigninUserRequest,
    UpdateUserRequest,
    Profile,
    ProfileList,
    CreateProfileRequest,
    UpdateProfileRequest,
    Event,
    EventList,
    CreateEventRequest,
    UpdateEventRequest,
    Training,
    TrainingList,
    CreateTrainingRequest,
    UpdateTrainingRequest,
    ErrorResponse
  }

  @behaviour OpenApiSpex.OpenApi

  @impl OpenApiSpex.OpenApi
  def spec do
    %OpenApi{
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
        },
        "/profiles" => %PathItem{
          get: %Operation{
            tags: ["profiles"],
            summary: "List profiles",
            description: "List all profiles",
            operationId: "ProfileController.index",
            responses: %{
              200 => Operation.response("Profile List", "application/json", ProfileList)
            }
          },
          post: %Operation{
            tags: ["profiles"],
            summary: "Create profile",
            description: "Create a new profile",
            operationId: "ProfileController.create",
            requestBody:
              Operation.request_body(
                "Profile attributes",
                "application/json",
                CreateProfileRequest,
                required: true
              ),
            responses: %{
              201 => Operation.response("Profile", "application/json", Profile),
              400 => Operation.response("Bad Request", "application/json", ErrorResponse)
            }
          }
        },
        "/profiles/{profile_id}" => %PathItem{
          get: %Operation{
            tags: ["profiles"],
            summary: "Get profile",
            description: "Get a profile by ID",
            operationId: "ProfileController.show",
            parameters: [
              Operation.parameter(:profile_id, :path, :string, "Profile ID", required: true)
            ],
            responses: %{
              200 => Operation.response("Profile", "application/json", Profile),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          put: %Operation{
            tags: ["profiles"],
            summary: "Update profile",
            description: "Update an existing profile",
            operationId: "ProfileController.update",
            parameters: [
              Operation.parameter(:profile_id, :path, :string, "Profile ID", required: true)
            ],
            requestBody:
              Operation.request_body(
                "Profile attributes",
                "application/json",
                UpdateProfileRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("Profile", "application/json", Profile),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          delete: %Operation{
            tags: ["profiles"],
            summary: "Delete profile",
            description: "Delete a profile by ID",
            operationId: "ProfileController.delete",
            parameters: [
              Operation.parameter(:profile_id, :path, :string, "Profile ID", required: true)
            ],
            responses: %{
              204 => Operation.response("No Content", "application/json", nil),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          }
        },
        "/profiles/by-user/{user_id}" => %PathItem{
          get: %Operation{
            tags: ["profiles"],
            summary: "Get profile by user ID",
            description: "Get a profile by user ID",
            operationId: "ProfileController.show_by_user",
            parameters: [
              Operation.parameter(:user_id, :path, :string, "User ID", required: true)
            ],
            responses: %{
              200 => Operation.response("Profile", "application/json", Profile),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          }
        },
        "/events" => %PathItem{
          get: %Operation{
            tags: ["events"],
            summary: "List events",
            description: "List all events",
            operationId: "EventController.index",
            responses: %{
              200 => Operation.response("Event List", "application/json", EventList)
            }
          },
          post: %Operation{
            tags: ["events"],
            summary: "Create event",
            description: "Create a new event",
            operationId: "EventController.create",
            requestBody:
              Operation.request_body(
                "Event attributes",
                "application/json",
                CreateEventRequest,
                required: true
              ),
            responses: %{
              201 => Operation.response("Event", "application/json", Event),
              400 => Operation.response("Bad Request", "application/json", ErrorResponse)
            }
          }
        },
        "/events/{event_id}" => %PathItem{
          get: %Operation{
            tags: ["events"],
            summary: "Get event",
            description: "Get an event by ID",
            operationId: "EventController.show",
            parameters: [
              Operation.parameter(:event_id, :path, :string, "Event ID", required: true)
            ],
            responses: %{
              200 => Operation.response("Event", "application/json", Event),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          put: %Operation{
            tags: ["events"],
            summary: "Update event",
            description: "Update an existing event",
            operationId: "EventController.update",
            parameters: [
              Operation.parameter(:event_id, :path, :string, "Event ID", required: true)
            ],
            requestBody:
              Operation.request_body(
                "Event attributes",
                "application/json",
                UpdateEventRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("Event", "application/json", Event),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          delete: %Operation{
            tags: ["events"],
            summary: "Delete event",
            description: "Delete an event by ID",
            operationId: "EventController.delete",
            parameters: [
              Operation.parameter(:event_id, :path, :string, "Event ID", required: true)
            ],
            responses: %{
              204 => Operation.response("No Content", "application/json", nil),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          }
        },
        "/events/by-user/{user_id}" => %PathItem{
          get: %Operation{
            tags: ["events"],
            summary: "Get events by user ID",
            description: "Get all events for a specific user",
            operationId: "EventController.show_by_user",
            parameters: [
              Operation.parameter(:user_id, :path, :string, "User ID", required: true)
            ],
            responses: %{
              200 => Operation.response("Event List", "application/json", EventList),
              500 =>
                Operation.response("Internal Server Error", "application/json", ErrorResponse)
            }
          }
        },
        "/trainings" => %PathItem{
          get: %Operation{
            tags: ["trainings"],
            summary: "List trainings",
            description: "List all trainings",
            operationId: "TrainingController.index",
            responses: %{
              200 => Operation.response("Training List", "application/json", TrainingList)
            }
          },
          post: %Operation{
            tags: ["trainings"],
            summary: "Create training",
            description: "Create a new training",
            operationId: "TrainingController.create",
            requestBody:
              Operation.request_body(
                "Training attributes",
                "application/json",
                CreateTrainingRequest,
                required: true
              ),
            responses: %{
              201 => Operation.response("Training", "application/json", Training),
              400 => Operation.response("Bad Request", "application/json", ErrorResponse)
            }
          }
        },
        "/trainings/{training_id}" => %PathItem{
          get: %Operation{
            tags: ["trainings"],
            summary: "Get training",
            description: "Get a training by ID",
            operationId: "TrainingController.show",
            parameters: [
              Operation.parameter(:training_id, :path, :string, "Training ID", required: true)
            ],
            responses: %{
              200 => Operation.response("Training", "application/json", Training),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          put: %Operation{
            tags: ["trainings"],
            summary: "Update training",
            description: "Update an existing training",
            operationId: "TrainingController.update",
            parameters: [
              Operation.parameter(:training_id, :path, :string, "Training ID", required: true)
            ],
            requestBody:
              Operation.request_body(
                "Training attributes",
                "application/json",
                UpdateTrainingRequest,
                required: true
              ),
            responses: %{
              200 => Operation.response("Training", "application/json", Training),
              404 => Operation.response("Not Found", "application/json", ErrorResponse)
            }
          },
          delete: %Operation{
            tags: ["trainings"],
            summary: "Delete training",
            description: "Delete a training by ID",
            operationId: "TrainingController.delete",
            parameters: [
              Operation.parameter(:training_id, :path, :string, "Training ID", required: true)
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
