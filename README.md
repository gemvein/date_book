# DateBook
[![GitHub version](https://badge.fury.io/gh/gemvein%2Fdate_book.svg)](http://badge.fury.io/gh/gemvein%2Fdate_book)
[![Build Status](https://travis-ci.org/gemvein/date_book.svg)](https://travis-ci.org/gemvein/date_book)
[![Coverage Status](https://coveralls.io/repos/gemvein/date_book/badge.svg)](https://coveralls.io/r/gemvein/date_book)
Date Book, still in alpha develpment, is a Rails 5 Engine to give Users the ability to publish and manage calendars of events.

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

And migrate your database again:
```bash
$ rake db:migrate
```

Add to the end of application.html:
```html
<%= render_footer_javascript %> 
```

## Build Occurences

```bash
$ rake schedulable:build_occurrences
```

## Automating Build of Occurences
See [Schedulable: Automate Build of Occurences](https://github.com/benignware/schedulable#automate-build-of-occurrences) for information on setting up a crontab to automate the build of occurences

## Contributing to Date Book
 
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
