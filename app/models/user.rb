class User < ActiveRecord::Base
  has_one :card

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      user.facebook
      # name = user.facebook.get_object("me")["name"]
      # location = user.facebook.get_object("me")["location"]
      # img_url = user.facebook.get_picture("me")
      # like = user.facebook.get_object(user.uid + '/likes?summary=1').raw_response["summary"]["total_count"];
      # binding.pry
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end
end
