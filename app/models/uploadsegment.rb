class Uploadsegment < ActiveRecord::Base
  belongs_to :upload
   has_many :articles, :dependent => :destroy
end
