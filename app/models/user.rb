class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  validates :name,  presence: true, length:{maximum: Settings.name_max_length}
  validates :email, presence: true, length: {maximum: Settings.email_max_length},
  format:{with: Settings.valid_email_regex}, uniqueness:{case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length:{minimum: Settings.pass_min_length}, allow_nil: true
  scope :order_by_name, ->{order :name}
  scope :things, ->{select :id, :name, :email}
  before_save :downcase_email
  before_create :create_activation_digest


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

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
