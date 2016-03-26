class StatesController < ApplicationController
  def show
    render json: {
      user_count: User.count,
      stranger_count: cache_keys_count
    }
  end
end
