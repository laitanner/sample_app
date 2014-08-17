class Message < ActiveRecord::Base
  validates :addressee_id, presence: true
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  def self.my_messages(user)
    where("user_id = :users_id OR addressee_id = :users_id",
          users_id: user.id)
  end
end
