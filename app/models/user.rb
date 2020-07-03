class User < ActiveRecord::Base
    has_many :sources, :dependent => :nullify
    has_many :topics, :dependent => :nullify # or destroy??? - decide when setting up shared sources
    has_many :subjects, :dependent => :nullify # or destroy??? - decide when setting up shared sources
    has_secure_password
    
    validates :username, presence: true, uniqueness: { case_sensitive: false, message: "not available" }, format: { with: /\A\w+\z/, message: "can only use letters and numbers without spaces" }
    validates :email, presence: true, uniqueness: { case_sensitive: false, message: "not available" }, format: { with: /\A\S+@\w+\.[a-zA-Z]{2,3}\z/, message: "doesn't look valid, please use another" }

    def full_name
        "#{self.first_name.capitalize} #{self.last_name.capitalize}"
    end

    def self.find_by_slug(url_slug)
        self.all.find { |obj| obj.slug == url_slug }
    end

    def slug
        self.username.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
    end
end