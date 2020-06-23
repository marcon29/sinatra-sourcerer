class Subject < ActiveRecord::Base
    has_many :topics
    has_many :sources, through: :topics
end