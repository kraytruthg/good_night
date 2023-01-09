# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_current_user

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveInteraction::InvalidInteractionError, with: :render_unprocessable_entity_response_from_interaction
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private 

  def set_current_user
    @current_user = User.find(params[:user_id])
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def render_unprocessable_entity_response_from_interaction(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { errors: exception.message }, status: :not_found
  end
end
