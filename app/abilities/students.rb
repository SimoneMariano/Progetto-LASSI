Canard::Abilities.for(:student) do
  can [:read, :addToFauvorites, :buy], Book
  cannot [:create, :edit, :destroy], Book

  can [:create, :read], BookRental
  cannot [:edit, :destroy], BookRental

  can [:read, :create, :edit, :destroy], Secondhand
  cannot [:approve], Secondhand

  cannot [:read, :create, :destroy, :edit], Author
  cannot [:read, :create, :destroy, :edit], Category
  cannot [:read, :create, :destroy, :edit], Course

  cannot [ :create, :destroy, :edit], Bulletin
  can [:read], Bulletin
end
