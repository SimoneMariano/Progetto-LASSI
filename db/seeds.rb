# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


User.create!([{
    email: "user@gmail.com",
    id: 1,
    created_at: DateTime.now,
    updated_at: DateTime.now,
    password: "password"

  },
  {
    email: "admin@gmail.com",
    id: 2,
    created_at: DateTime.now,
    updated_at: DateTime.now,
    password: "administrator",
    roles_mask: 2
  }
  ])
