Friendship.create!([
  {user_id: 1, friend_id: 2},
  {user_id: 1, friend_id: 4},
  {user_id: 4, friend_id: 2},
  {user_id: 4, friend_id: 3}
])
User.create!([
  {first_name: "Pedro", last_name: "Alvarado"},
  {first_name: "Andres", last_name: "Vizcaino"},
  {first_name: "Guilson", last_name: "Guerra"},
  {first_name: "Yonatan", last_name: "Valencia"}
])
