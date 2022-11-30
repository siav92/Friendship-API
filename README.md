## Overview

For this assignment, your task is to build an API for a web application using [Ruby on Rails](https://rubyonrails.org/). We're already defined the API specification and requirements, but we need you to actually build it and get it ready for production use.

## Requirements

- This should be production-ready code that we can run and build on top of.
- The API should at a minimum follow the specifications listed below.
- You are free to use whatever open source packages you're comfortable with, but be sure to implement the database models and relations logic yourself. Describe your choices and decisions in the `SUBMISSION.md` file along with your code.
- For the database, please use PostgreSQL.

## API Specifications

This API will allow users to signup, login, create friend relationships with other users, and provide a way to fetch `users` and `friends` resources.

Your API will need to implement authentication to ensure logged in users can only access their own data. For authentication, we'll be using JSON Web Tokens (https://jwt.io/).
The consumer of this API will be sending requests with the JWT in the `Authorization` header (`Authorization: Bearer <token>`).
Feel free to use the [`ruby-jwt` gem](https://github.com/jwt/ruby-jwt) (or another JWT implementation).

### `POST /signup`

Endpoint to create a user in the database.

- [ ] Two users with the same `email` should not be allowed to exist
- [ ] The response should return a JWT token that can be used for authenticating other endpoints

The input payload should follow this structure:

```json
{
  "user": {
    "email": "test@copmany.com",
    "name": "Alex Zimmerman",
    "password": "copmany"
  }
}
```

The response body should follow this structure:

```json
{
  "token": "some_jwt_token"
}
```

### `POST /login`

Endpoint to log a user in.

- [ ] The response should return a JWT token that can be used for authenticating other endpoints

The input payload should follow this structure:

```json
{
  "login": {
    "email": "test@copmany.com",
    "password": "copmany"
  }
}
```

The response body should follow this structure:

```json
{
  "token": "some_jwt_token"
}
```

### `GET /users`

Endpoint to retrieve a list of all users.

- [ ] This endpoint should require a valid `Authorization` header to be passed in with the request

The input payload should be empty.

The response body should follow this structure:

```json
{
  "users": [
    {
      "name": "Alex Zimmerman",
      "email": "test@copmany.com"
    }
  ]
}
```

### `POST /users/:email/friendship`

Endpoint to create a relationship between the logged in user and the user found via the `:email` param.

- [ ] Users should only be allowed befriend each other once.
- [ ] If another user adds you as a friend, it should be returned in the `GET /users/me/friends` response as well.
- [ ] This endpoint should require a valid `Authorization` header to be passed in with the request

The input payload should be empty.

The response body should follow this structure:

```json
{
  "friendship": {
    "user": {
      "name": "Logged in user",
      "email": "loggedin@user.com"
    },
    "friend": {
      "name": "Friend Name",
      "email": "friend@email.com"
    }
  }
}
```

#### `GET /users/me/friends`

Endpoint that returns all of the logged in user's friends, regardless of who initiated the friendship.

- [ ] This endpoint should require a valid `Authorization` header to be passed in with the request

The response body should follow this structure:

```json
{
  "friends": [
    {
      "name": "Alex Zimmerman",
      "email": "test@copmany.com"
    }
  ]
}
```

These instructions do not specify every possible detail you should take into consideration. This is done intentionally to test your ability to analyze the problem and come up with a creative solution. Thoroughness and attention to detail are two of the most important qualities for this role.

Good luck!
