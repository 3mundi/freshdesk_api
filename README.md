# FreshdeskAPI

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/freshdesk_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'freshdesk_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freshdesk_api

## Usage

### Tickets
**Create:**
```ruby
response = FreshdeskAPI::Ticket.create(
  description:"Some details on the issue ...",
  subject:"Support needed..",
  email:"apanach@path.travel",
  priority: 1,
  status: 2
)
response.priority #=> 1
response.display_id #=> 14
```
**Show:**
```ruby
response = FreshdeskAPI::Ticket.show(14)
response.priority #=> 1
response.display_id #=> 14
```
**Update:**
```ruby
response = FreshdeskAPI::Ticket.show(14, priority: 2)
response.priority_name #=> 'Medium'
response.priority #=> 2
response.display_id #=> 14
```
**Destroy:**
```ruby
FreshdeskAPI::Ticket.destroy(14)
# => true
```

**Index:**
```ruby
response = FreshdeskAPI::Ticket.index
ticket = response.first
ticket.priority #=> 1
ticket.display_id #=> 14
```

**Add note:**
```ruby
response = FreshdeskAPI::Ticket.add_note(
  17,
  body: 'Hi Mum!',
  private: false
)
response.body #=> 'Hi Mum!'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/freshdesk_api.
