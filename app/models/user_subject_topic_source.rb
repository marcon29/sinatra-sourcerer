class UserSubjectTopicSource < ActiveRecord::Base
    belongs_to :user
    belongs_to :subject
    belongs_to :topic
    belongs_to :source
end