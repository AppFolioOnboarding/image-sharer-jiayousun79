require 'json'

module Api
  class FeedbacksController < ApplicationController
    def create
      if JSON.parse(request.body.read)['feedbackText'].empty?
        head :bad_request
      else
        render json: request.body.read
      end
    end
  end
end
