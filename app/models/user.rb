class User < ActiveRecord::Base
  has_many :authentications

  devise :rememberable, :trackable, :validatable,
          :database_authenticatable, :registerable, :recoverable
  rolify
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  
  validates_presence_of :name
  accepts_nested_attributes_for :authentications, :reject_if => proc { |attr| attr['username'].blank? }
  mount_uploader :avatar, AvatarUploader
  
  def apply_omniauth(omniauth)
    if omniauth['provider'] == 'twitter'
      logger.warn(omniauth['info'].inspect)
      self.username = omniauth['info']['nickname']
      self.name = omniauth['info']['name']
      self.name.strip!
      identifier = self.username

    elsif omniauth['provider'] == 'facebook'
      self.email = omniauth['info']['email'] if email.blank?
      self.username = omniauth['info']['nickname']
      self.name = omniauth['info']['first_name'] + ' ' + omniauth['info']['last_name']
      self.name.strip!
      identifier = self.username
      # self.location = omniauth['extra']['user_hash']['location']['name'] if location.blank?
    elsif omniauth['provider'] == 'google_oauth2'
      self.email = omniauth['info']['email'] 
      self.name = omniauth['info']['name']
      self.username = omniauth['info']['email']
      identifier = self.username
    end
    self.email = omniauth['info']['email'] if email.blank?
    self.password = SecureRandom.hex(32) if password.blank?  # generate random password to satisfy validations
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :username => identifier)
  end


end
