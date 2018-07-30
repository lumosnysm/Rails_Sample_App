class User < ApplicationRecord
  attr_accessor :remember_token
  before_save{email.downcase!}
  validates :name,  presence: true, length:{maximum: Settings.name_max_length}
  validates :email, presence: true, length: {maximum: Settings.email_max_length},
  format:{with: Settings.valid_email_regex}, uniqueness:{case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length:{minimum: Settings.pass_min_length}, allow_nil: true
  scope :order_by_name, ->{order :name}
  scope :things, ->{select :id, :name, :email}


  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end
end
