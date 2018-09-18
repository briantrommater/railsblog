class User < ApplicationRecord
    has_many :posts
    has_many :comments

    validates_presence_of :email

    scope :created_today, -> {where("created_at BETWEEN ? AND ?", 
    Date.today.beginning_of_day, Time.now)}

    scope :created_on_date, -> (date) { where("created_at BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)}

end
