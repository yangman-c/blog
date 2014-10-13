Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '5396dbec29104fa06c14',
    '86794bd50b36e5b087f05ff85d20351b22e8a36a'
end