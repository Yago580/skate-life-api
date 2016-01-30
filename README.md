# skate-life-api
[![Dependency Status](https://gemnasium.com/yago580/skate-life-api.svg)](https://gemnasium.com/yago580/skate-life-api) [![Build Status](https://travis-ci.org/yago580/skate-life-api.svg)](https://travis-ci.org/yago580/skate-life-api)

`https://skate-life-api.herokuapp.com`

### Skateparks
* `GET /skateparks`
* `GET /skateparks/:id`

### Users
* `GET /users`
* `POST /users` `email, password`
* `GET /users/:id`
* `DELETE /users/:id`

### Associations

#### Favorites
* `POST /favorites` `user_id, skatepark_id`
* `DELETE /favorites/:user_id/:skatepark_id`
