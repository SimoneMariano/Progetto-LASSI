require "rails_helper"

RSpec.describe Category, type: :model do
    describe "associations" do 
        it { should have_and_belong_to_many(:book)  }

        it { should validate_presence_of(:name) }
        it { should validate_uniqueness_of(:name) }
    end
end