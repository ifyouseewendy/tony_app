class StatesController < ApplicationController
  def show
    render json: {
      user_count: User.count,
      stranger_count: cache.instance_variable_get(:@data).keys.count
    }
  end
end
