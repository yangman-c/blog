# encoding: utf-8
class ApplicationController < ActionController::Base
  # protect_from_forgery
	# before_filter :set_locale
	
	def default_url_options(options={})
	  logger.debug "default_url_options is passed options: #{options.inspect}\n"
	  { :locale => I18n.locale }
	end

	def logged_in?
		current_user ? true : false
	end

	# 设置应用页面的语言
private
	def set_locale
	  I18n.locale = extract_locale_from_tld || I18n.default_locale
	end
	

	def extract_locale_from_tld
	  parsed_locale = request.host.split('.').last
	  I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
	end

	# 设置时区
	def set_time_zone
		Time.zone = current_user.time_zone if logged_in?
	end
end
