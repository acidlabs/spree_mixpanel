SpreeMixpanel
=============

[Spree](http://spreecommerce.com/) integration with [Mixpanel](https://mixpanel.com)

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

### Sidekiq (Optional)

In order to upload data to mixpanel in background you can use [Sidekiq](http://sidekiq.org/) gem.

Run your redis server
```shell
redis-server
```

Execute Sidekiq
```shell
bundle exec sidekiq
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
      'Total sales' => self.total_sales # personalized method in your user model
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
      'Personal amount' => self.personal_amount
    }
  end
end
```
### Tracking order revenue

```ruby
@order.mixpanel_track_charges
```

By default paid orders revenue  are automatically sent to mixpanel.

You can change this behaviour changing `push_order_charges` configuration.

```ruby
# config/initializers/mixpanel.rb
Spree::Mixpanel::Config.configure do |config|
  config.push_order_charges = false # true by default
end
```

You can override `mixpanel_total`.

```ruby
Order.class_eval do
  def mixpanel_total
    100 # personalized total
  end
end
```
In order to send personalized fields you can override `mixpanel_charge_fields`

```ruby
Order.class_eval do
  def mixpanel_charge_fields
    {'User name' => user_name } # personalized field
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
