class Source < ActiveRecord::Base
    has_many :source_topics
    has_many :topics, through: :source_topics
    has_many :subjects, through: :topics


    # belongs_to :topic
    # belongs_to :user

    # has_many :user_subject_topic_sources
    # has_many :users, through: :user_subject_topic_sources
    # has_many :subjects, through: :user_subject_topic_sources
    # has_many :topics, through: :user_subject_topic_sources
end