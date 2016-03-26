class PagesController < ApplicationController
  def index
    if current_user.present?
      @data = {
        user_signed_in: true,
        user_name: current_user.name,
        sign_in_count: current_user.sign_in_count,
        sign_in_time: ( (Time.now - current_user.current_sign_in_at) / 60 ).to_i
      }
      render :index
    else
      if session[:stranger_id].present?
        token             = session[:stranger_id]
        first_visited_at  = session[:first_visited_at]
        visit_time        = ( (Time.now - Time.parse(first_visited_at)) / 60 ).to_i
      else
        token                      = Devise.friendly_token
        session[:stranger_id]      = token
        session[:first_visited_at] = Time.now
        cache.write(token, true, expires_in: 1.minute)
        visit_time = 0
      end

      @data = {
        visit_time: visit_time
      }
    end
  end

  private

    def cache
      @_cache ||= Rails.cache
    end
end
