Canard::Abilities.for(:user) do
  can [:read, :buy], Book
  cannot [:create, :edit, :destroy], Book

  can [:create, :read], BookRental
  cannot [:edit, :destroy], BookRental

  can [:read, :create, :edit, :destroy], Secondhand
  cannot [:approve], Secondhand

  cannot [:read, :create, :destroy, :edit], Author
  cannot [:read, :create, :destroy, :edit], Category
  cannot [:read, :create, :destroy, :edit], Course

end