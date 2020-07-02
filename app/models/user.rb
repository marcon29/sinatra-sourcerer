class User < ActiveRecord::Base
    
    # ####### join table with sources??? #######
    has_many :sources, :dependent => :nullify
    has_many :topics, through: :sources
    has_many :subjects, through: :sources    
    has_secure_password
    
    validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A\w+\z/, message: "can only use letters and numbers without spaces" }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A\S+@\w+\.[a-zA-Z]{2,3}\z/, message: "doesn't look valid, please use another" }


    
    def full_name
        "#{self.first_name.capitalize} #{self.last_name.capitalize}"
    end


    # these slug methods are kind of pointless with above parameters for username
    # should just be able to use the username instead of slug
    def self.find_by_slug(url_slug)
        self.all.find do |obj|
            obj.slug == url_slug
        end
    end

    def slug
        self.username.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end



    
    
end