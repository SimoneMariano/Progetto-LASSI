Canard::Abilities.for(:admin) do
  can [:read, :create, :edit, :destroy], Book
  
end
