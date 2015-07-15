class TwitterAccount < ActiveRecord::Base
  # Attributes:  latitude, longitude, address, is_national
  #              consumer_key, consumer_secret, user_token, user_secret
  #              screen_name, twitter_account_info, language

  has_many :tweets
  has_one :user
  serialize :twitter_account_info

  geocoded_by :address
  before_save :geocode, if: lambda {
    self.address.present? && (latitude.blank? || self.address_changed?)
  }

  def self.create_from_twitter_oauth(info)
    self.create({screen_name: info['info']['nickname'],
      address: info['info']['location'],
      consumer_key: ENV['OMNIAUTH_CONSUMER_KEY'],
      consumer_secret: ENV['OMNIAUTH_CONSUMER_SECRET'],
      user_token: info['credentials']['token'],
      user_secret: info['credentials']['secret']
    })
  end

  def twitter_account_url
    "https://twitter.com/#{screen_name}"
  end

  def twitter_link
    "<a href='#{twitter_account_url}'>@#{screen_name}</a>"
  end

  def get_account_info
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = user_token
      config.access_token_secret = user_secret
    end
    result = client.user(screen_name)
    self.twitter_account_info = result.to_h
  end

  def account_info_name
    return nil unless twitter_account_info.present?
    twitter_account_info[:name]
  end

  def account_info_image
    return nil unless twitter_account_info.present?
    twitter_account_info[:profile_image_url_https]
  end

  def self.fuzzy_screenname_find(n)
    if !n.blank?
      self.where("lower(screen_name) = ?", n.downcase.strip).first
    else
      nil
    end
    
  end

end
