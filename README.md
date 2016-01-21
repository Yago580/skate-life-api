# skate-life-api
[![Dependency Status](https://gemnasium.com/yago580/skate-life-api.svg)](https://gemnasium.com/yago580/skate-life-api)

### Skateparks
* `GET /skateparks`
* `GET /skateparks/:id`

### Users
* `GET /users`
* `POST /users` `email, password`
* `GET /users/:id`
* `DELETE /users/:id`

### Favorites
* `POST /favorites` `user_id, skatepark_id`
* `DELETE /favorites/:user_id/:skatepark_id`
