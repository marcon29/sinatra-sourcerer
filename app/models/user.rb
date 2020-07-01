class User < ActiveRecord::Base
    
    # ####### join table with sources??? #######
    has_many :sources
    has_many :topics, through: :sources
    has_many :subjects, through: :sources
    has_secure_password

    
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    
end