class Message < ActiveRecord::Base
  validates :addresser_id, presence: true
  validates :addressee_id, presence: true
  default_scope -> { order('created_at DESC') }
  belongs_to :addresser, class_name: "User", foreign_key: "addresser_id"
  belongs_to :addressee, class_name: "User", foreign_key: "addressee_id"
end
