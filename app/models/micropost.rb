class Micropost < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true


  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids} AND to_id = 0) OR user_id = :user_id OR to_id = :user_id",
          user_id: user.id)
  end

  # Sets to_id. to_id is the id of the user that the reply is for.
  def set_to_id
    user_name = self.content
    if user_name.index("-") != nil
      if user_name[0..user_name.index('-')].match(/@\S+-/)
        self.update(to_id: user_name[1..user_name.index('-')-1].to_i)
      end
    end
  end

  #returns message recipient id if micropost is intended to be a direct message, 0 if not
  def message_recipient
    user_name = self.content
    if user_name.index("-") != nil
      if user_name[0..user_name.index('-')].match(/d\S+-/)
        return user_name[1..user_name.index('-')-1].to_i
      else
        return 0
      end
    else
      return 0
    end
  end
end