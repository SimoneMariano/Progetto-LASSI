Canard::Abilities.for(:user) do
  can [:read, :buy], Book
  cannot [:create, :edit, :destroy], Book

  can [:create, :read], BookRental
  cannot [:edit, :destroy], BookRental
end