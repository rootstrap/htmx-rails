# Htmx::Rails

[HTMX](https://htmx.org/) ruby gem for Ruby on Rails.

## Installation

### Gem installation

Add `htmx-rails` to your `Gemfile`:

```ruby
gem 'htmx-rails'
```

And then execute in your shell:

```
bundle install
```

Or install it yourself by executing:

```
gem install htmx-rails
```

### After installing the gem, run the installer:

```
rails g htmx:install
```

## Usage


```HTML
<!-- have a button POST via AJAX -->
<button hx-post="/clicked" hx-swap="outerHTML">
  Click Me
</button>
```

### Read the [docs](https://htmx.org/docs/) for a more in-depth introduction.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rootstrap/htmx-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rootstrap/htmx-rails/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Htmx::Rails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rootstrap/htmx-rails/blob/master/CODE_OF_CONDUCT.md).
