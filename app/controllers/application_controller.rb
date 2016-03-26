class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def cache
      # FIXME
      #
      # When using Rails.cache, defaults to FileStore. It doesn't provide the API to list keys.
      # When using MemoryStore, it can hack to list keys. But it can't maintain data over requests.
      #
      # ( Of course, we should use Reids/MemCache in production. They can provide full features. )
      @_cache ||= ActiveSupport::Cache::MemoryStore.new # Rails.cache
    end

    def cache_keys_count
      cache.instance_variable_get(:@data).keys.count
    end
end
