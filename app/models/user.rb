class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable, :omniauthable, omniauth_providers: %i(google facebook)

  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(email: auth.info.email,
                         provider: auth.provider,
                         uid: auth.uid,
                         token: auth.credentials.token,
                         encrypted_password: Devise.friendly_token[0, 20])
    end
    user
  end

  def self.find_for_facebook(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(email: auth.info.email,
                         provider: auth.provider,
                         uid: auth.uid,
                         token: auth.credentials.token,
                         encrypted_password: Devise.friendly_token[0, 20])
    end
    user
  end
end
