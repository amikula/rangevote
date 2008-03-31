class Vote < ActiveRecord::Base
  serialize :ratings
  belongs_to :poll
end
