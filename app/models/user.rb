class User < ActiveRecord::Base
    has_many :user_subject_topic_sources

    has_many :subjects, through: :user_subject_topic_sources
    has_many :topics, through: :user_subject_topic_sources
    has_many :sources, through: :user_subject_topic_sources
    has_secure_password
end