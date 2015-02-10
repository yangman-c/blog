module ApplicationHelper
	def get_zone
		ActiveSupport::TimeZone.all
	end
end
