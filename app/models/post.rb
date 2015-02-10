# encoding: utf-8
class Post < ActiveRecord::Base
  validates_presence_of :title, :content
  validates_uniqueness_of :title
  
  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings

	scope :tag_with, lambda{|tag_name| joins(:tags).where("tags.name = ?", tag_name)}
	scope :latter_than, lambda{|time| joins(:taggings).where("taggings.created_at < ?", time)}

  def self.get_chinses_week(d)
  	chinses_week =  case d
								  	when 0
									  	 "星期天"	
								  	when 1
									  	 "星期一"	
								  	when 2
									  	 "星期二"
								  	when 3
									  	 "星期三"	
								  	when 4
									  	 "星期四"	
								  	when 5
									  	 "星期五"	
								  	when 6
									  	 "星期六"	
								  	end
		chinses_week
  end

  # Post.tag_with('yuejie') 找到 打了yuejie标签 的post
	# def self.tag_with(tag_name)
	# 	Tag.find_by_name(tag_name).try(:posts)
	# end


	def get_meeting_room
		["采购中心505会议室", "采购中心605会议室", "铁道大厦", "国二招", "采购业务接待室", "国谊宾馆", "采购中心624会议室", "一级市场", "二级市场", "良乡", "银龙苑宾馆"]
	end
end
