class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

    def render_jsonapi_response(resource)
        if resource.errors.empty?
          render jsonapi: resource
        else
          validation_error(resource)
        end
    end

    def validation_error(resource)
      render json: {
        'errors': [
          {
            status: '400',
            title: 'Bad Request',
            detail: resource.errors,
            code: '100'
          }
        ]
      }, status: :bad_request
    end

end
