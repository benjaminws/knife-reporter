# Knife::Reporter

A knife plugin for gathering and reporting data about nodes, and the chef
environment, in various formats.

## Installation

Add this line to your application's Gemfile:

    gem 'knife-reporter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install knife-reporter

## Usage

### Report on nodes
    $ knife reporter nodes cli
    $ knife reporter nodes rst
        -o, --outfile FILE               File to write the report to

### Report on roles
    $ knife reporter roles cli
    $ knife reporter roles rst
        -o, --outfile FILE               File to write the report to


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
