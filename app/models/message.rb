class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User"
  has_many :comments
end
