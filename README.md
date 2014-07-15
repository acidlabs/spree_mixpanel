SpreeMixpanel
=============

Spree integration with Mixpanel

Installation
------------

Add spree_mixpanel to your Gemfile:

```ruby
gem 'spree_mixpanel', git: 'git@github.com:marcosteixeira/spree_mixpanel.git', branch: '2-1-stable'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_mixpanel:install
```

Usage
------------

Add your Mixpanel credentials to `config/initializers/mixpanel.rb`:

```ruby
Spree::Mixpanel::Config.configure do |config|
  config.connection_token = "YOUR TOKEN"
end
```

### Storing user profiles

```ruby
@user.mixpanel_track_user
```

By default, we send `first_name`, `last_name`, and `email` from user. You can override user `mixpanel_personal_fields` and return personalized fields.

```ruby
User.class_eval do
  def mixpanel_personal_fields
    { 
      'My Field' => 'FIELD',
      'Total sales' => self.total_sales
    }
  end
end
```

### Sending orders to mixpanel

```ruby
@order.mixpanel_track_order
```

By default, we send `number`, `total`, `state`, `email` and `payment_state` from order. You can override order `mixpanel_personal_fields` and return personalized fields.

```ruby
Order.class_eval do
  def mixpanel_personal_fields
    {
      'My Field' => 'FIELD',
      'Personal amout' => self.personal_amount
    }
  end
end
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_mixpanel/factories'
```

Copyright (c) 2014, released under the New BSD License
