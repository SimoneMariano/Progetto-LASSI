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

  can [:read], Seat
  cannot [:disable, :edit, :destroy, :create], Seat

  can [:destroy, :read, :create], Reservation
  cannot [:edit], Reservation


end
