require "grape-swagger"

module API
  class Base < Grape::API
    mount API::V1::Base

    add_swagger_documentation(
      API_version: "v1",
      hide_documentation_path: true,
      mount_path: "/api/v1/swagger_doc",
      hide_format: true
    )
  end
end
