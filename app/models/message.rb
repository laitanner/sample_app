class Message < ActiveRecord::Base
  validates :addresser_id, presence: true
  validates :addressee_id, presence: true
  default_scope -> { order('created_at DESC') }
  belongs_to :addresser, class_name: "User", foreign_key: "addresser_id"
  belongs_to :addressee, class_name: "User", foreign_key: "addressee_id"

  def self.my_sent_messages(user)
    where("addresser_id = :user_id",
          user_id: user.id)
  end

  def self.my_received_messages(user)
    where("addressee_id  = :user_id",
          user_id: user.id)
  end
end
