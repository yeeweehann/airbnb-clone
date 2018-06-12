class Listing < ActiveRecord::Base
  belongs_to :user
  paginates_per 15
  enum verified: [:true, :false]
end
