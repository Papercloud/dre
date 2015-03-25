# DRE
A **D**evice **R**egistration **E**ngine for Rails.

Adds a `Device` model for your Rails app, as well as a set of routes to register and deregister devices by supplying a token.

## Installation

Add the gem into your project:

```
gem 'dre'
bundle install
```

Then run the installation:
```
rails g dre:install
rake db:migrate
```

## Usage

Add the `acts_as_device_owner` method into your user model:

```
class User < ActiveRecord::Base
  acts_as_device_owner
end
```

Mount the engine in your `routes.rb` file:
```
Rails.application.routes.draw do
  mount Dre::Engine => '/'
end
```

This will add three routes into your application:

|                           |                                                       |
|---------------------------|-------------------------------------------------------|
| `GET /devices`            | Get all of the devices for the current user           |
| `PUT /devices/:token`     | Register a new device if it doesn't exist             |
| `DELETE /devices/:token`  | Deregister the device belonging to the supplied token |

## Configuration

```
Dre.setup do |config|
  # Dre will call this within DevicesController to ensure the user is authenticated.
  config.authentication_method = :authenticate_user!

  # Dre will call this within DevicesController to return the current logged in user.
  config.current_user_method = :current_user
end

```

The default configuration integrates with [Devise](https://github.com/plataformatec/devise), but if you have other methods of authentication and retrieving the currently authenticated user, you can specify them here and the `DevicesController` will use those in the before filter.