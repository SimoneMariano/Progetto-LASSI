Canard::Abilities.for(:user) do
  can [:read, :buy], Book
  cannot [:create, :edit, :destroy], Book

  can [:read, :create], Book_rental
  cannot [:edit, :destroy], Book_rental
end
