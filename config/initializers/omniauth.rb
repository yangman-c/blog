OmniAuth.config.on_failure do |env|
  [302, {'Location' => "/auth/#{env['omniauth.error.strategy'].name}/failure?message=#{env['omniauth.error.type']}"}, ["Redirecting..."]]
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '5396dbec29104fa06c14',
    'c6cac176a6afea96fbad0e64d27e8e38189907bb'

  provider :identity, :fields => [:nickname, :email]#, on_failed_registration :UsersController.action(:new)
end