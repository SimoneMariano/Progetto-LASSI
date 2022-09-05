Canard::Abilities.for(:admin) do
  can [:read, :create, :edit, :destroy], Book
  cannot [:buy, :addToFavourites], Book
  
  can [:read, :destroy], BookRental
  cannot [:edit, :create], BookRental

  can [:read, :destroy, :approve], Secondhand
  cannot [:edit, :create], Secondhand

  can [:read, :create, :destroy, :edit], Author
  can [:read, :create, :destroy, :edit], Category
  can [:read, :create, :destroy, :edit], Course
  
end
