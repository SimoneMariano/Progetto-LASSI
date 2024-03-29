class User < ApplicationRecord
    has_many :book_rental, :as => :student
    has_many :book, :through => :book_rental, :as => :student
    has_many :secondhand, :as => :student
    has_many :book, :through => :secondhand, :as => :student
    has_one_attached :image
    has_one :course, dependent: :destroy
    has_and_belongs_to_many :book, dependent: :destroy

    has_many :seat, :through => :reservation
    has_many :reservation, dependent: :destroy

    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]

    
    after_initialize :set_default_role, :if => :new_record?
    acts_as_user :roles => [:student, :admin]


    def set_default_role
        if self.roles_mask.blank?
            self.roles_mask = 1 #student role
        end
        
    end
    

    def self.from_omniauth(auth)
        #where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
         #   user.email = auth.info.email
          #  user.password = Devise.friendly_token[0,20]
        #end
        @user = User.find_by(email: auth.info.email)
        if @user.present?
            @user.provider = auth.provider
            @user.uid = auth.uid
            @user
        else
            @user = User.create(email: auth.info.email, password: Devise.friendly_token[0,20], provider: auth.provider, uid: auth.uid)
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
