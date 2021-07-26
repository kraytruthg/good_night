class V1::SleepsController < ApplicationController
  def index
    if user = User.find_by(id: params[:user_id])
      @sleeps = Sleep.where(user: user).order(created_at: :desc)
    else
      @sleeps = Sleep.all.order(created_at: :desc)
    end
  end
end
