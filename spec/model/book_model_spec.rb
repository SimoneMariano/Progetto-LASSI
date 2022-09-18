require "rails_helper"

RSpec.describe Book, type: :model do
    describe "associations" do 
        it { should have_many(:book_rental)  }
        it { should have_many(:secondhand)  }
        it { should have_and_belong_to_many(:category)  }
        it { should have_and_belong_to_many(:course)  }
        it { should have_and_belong_to_many(:author)  }
        it { should have_one_attached(:placeholder)  }
        it { should have_and_belong_to_many(:user)  }

        it { should validate_presence_of(:ISBN) }
        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:placeholder) }
        it { should validate_presence_of(:stock) }

    end
end