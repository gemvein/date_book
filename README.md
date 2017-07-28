# DateBook
Date Book, not yet real, will become a Rails 5 Engine for managing and publishing a calendar of events.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'date_book'
```

And then execute:
```bash
$ bundle
```

Now, restart the rails server.

Create a User model if you don't have one:
```bash
$ rails g model User name:string
$ rake db:migrate
```

Then run the generator:
```bash
$ rails g date_book:install
```

Add to the end of application.html:
```html
<%= render_footer_javascript %> 
```

## Contributing to Paid Up
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Contributors
* [Karen Lundgren](https://github.com/nerakdon)
* [Chad Lundgren](https://github.com/chadlundgren)

## Copyright

Copyright (c) 2017 [Gem Vein](https://www.gemvein.com). See LICENSE.txt for further details.
