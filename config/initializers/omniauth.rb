Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '5396dbec29104fa06c14',
    'c6cac176a6afea96fbad0e64d27e8e38189907bb'
end