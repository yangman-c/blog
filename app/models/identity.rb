class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :nickname, :email
  validates_uniqueness_of :nickname, :email
  validates_format_of :email, :with => /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9-]+[\.a-zA-Z]+$/
end
