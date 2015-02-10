if defined?(Rails.configuration) && Rails.configuration.respond_to?(:middleware)
  Rails.configuration.middleware.insert_before ActionDispatch::Cookies, Rack::CleanCookies::Middleware
end