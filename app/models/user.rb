class User < ActiveRecord::Base
	validates :nickname, :presence => true
  validates :email, :uniqueness => true
	# validates :email, :presence => true, :uniqueness => true
	has_many :authentications
	accepts_nested_attributes_for :authentications
  accessor_attributes :time_zone

  def add_auth(auth)
    # debugger
    authentications.create(:provider => auth[:provider], :uid => auth[:uid])
  end

  class << self
    def find_by_nickname_or_email(auth)
      condition = ["1=1"]
      if auth[:nickname]
        condition << "nickname = '#{auth[:nickname]}'"
      elsif auth[:email]
        condition << "email = '#{auth[:email]}'"
      end
      find :first, :conditions => condition.join(" and ")
    end

    def from_auth(auth)
      # debugger
      locate_auth(auth) || locate_email(auth) || create_auth(auth)
		end

    def locate_auth(auth)
      Authentication.find_by_provider_and_uid(auth[:provider], auth[:uid]).try(:user)
    end

    def locate_email(auth)
      user = find_by_nickname_or_email(auth[:info])
      return unless user
      if auth[:info][:email]
        user.email = auth[:info][:email]
        user.save
      end
      user.add_auth(auth)
      # debugger
      user
    end

    def create_auth(auth)
      create!(:nickname => auth[:info][:nickname], :email => auth[:info][:email],
              :authentications_attributes => [Authentication.new(:provider => auth[:provider],                                                                                :uid =>auth[:uid]).attributes]
      )
    end
  end
end
