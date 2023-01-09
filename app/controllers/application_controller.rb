# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_current_user

  private 

  def set_current_user
    @current_user = User.find(params[:user_id])
  end
end
