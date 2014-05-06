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

    end
  end

  def facebook(user)

    @facebook ||= Koala::Facebook::API.new(oauth_token)

    user.card.name = @facebook.get_object("me")["name"]
    user.card.location = @facebook.get_object("me")["location"]["name"]
    user.card.img_url = @facebook.get_picture("me")

    @posts = @facebook.get_connections("me", "posts")

    user.card.num_post = @posts.count

    @photo_posts = 0
    @status_posts = 0
    @link_posts = 0
    @video_posts = 0

    @comments_count = 0
    @likes_count = 0
    @posts.each do |i|
      comments = @facebook.get_connections(i["id"] , "comments")

      if i["likes"]
        @likes_count += i["likes"]["data"].length
      end
      @comments_count += comments.length

      case i["type"]
      when "photo"
        @photo_posts += 1
      when "status"
        @status_posts += 1
      when "link"
        @link_posts += 1
      when "video"
        @video_posts += 1
      end

      comments.each do |j|
        @likes_count += j["like_count"]
      end
    end
    user.card.num_comment = @comments_count
    user.card.num_like = @likes_count
    user.card.num_photo = @photo_posts
    user.card.num_status = @status_posts
    user.card.num_link = @link_posts
    user.card.num_video = @video_posts

    binding.pry

    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  # def comments_count
  #   comments_count = 0
  #   faceboo_id = @facebook["id"]
  #   @posts.each do |i|
  #     binding.pry
  #     comments_count += @facebook.get_connections(facebook_id + '_' + i["id"] , "comments").count
  #   end
  #   comments_count
  # end
end
