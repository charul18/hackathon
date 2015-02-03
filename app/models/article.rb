class Article < ActiveRecord::Base
  belongs_to :uploadsegment
  attr_accessible :title, :author, :content, :created_at
end
