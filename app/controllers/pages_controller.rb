class PagesController < ApplicationController
  def index
    if current_user
      @data = {
        user_name: current_user.name,
        sign_in_count: current_user.sign_in_count,
        sign_in_minute: ( (Time.now - current_user.current_sign_in_at) / 60 ).to_i
      }
      render :index
    else
    end
  end
end
