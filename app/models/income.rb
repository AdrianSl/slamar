class Income < ActiveRecord::Base
  belongs_to :source, polymorphic: true
end
