class User < ApplicationRecord
    has_many :book_rental
    has_many :book, :through => :book_rental

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]



    

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
        end
    end

    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
                user.email = data["email"] if user.email.blank?
            end
        end
    end
end
