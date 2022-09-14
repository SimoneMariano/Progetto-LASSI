FactoryBot.define do
    factory :book do
        title { "Lezioni di fisica. Con e-book. Vol. 1: Meccanica, termodinamica." }
        description { "Some description" }
        stock { 3 }
        ISBN { 9788808420206 }

        author { [ create(:author, name: "Daniele Sette"), create(:author, name: "Mario Bertolotti"), create(:author, name: "Adriano Alippi") ] }
        course { [ create(:course, name: "Ingegneria Informatica e Automatica"), create(:course, name: "Fisica") ] }
        category { [ create(:category, name: "Fisica") ] }

        placeholder { Rack::Test::UploadedFile.new('db/seeds/fisica_1.jpg') }

    end
end


