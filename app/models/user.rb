class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  before_create :generate_nexmo_developer_api_secret

  def generate_nexmo_developer_api_secret
    loop do
      self.nexmo_developer_api_secret = SecureRandom.hex
      break unless User.exists?(nexmo_developer_api_secret: nexmo_developer_api_secret)
    end
  end
end
