class User < ActiveRecord::Base
    has_many :sources
    has_secure_password
end