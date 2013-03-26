# LabelGen

Asset label generation library with the following features:

* Customizable template
* QR Codes corresponding to each asset number
* Database backed number sequence

## Installation

Add this line to your application's Gemfile:

    gem 'label_gen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install label_gen

## Integration

A host application is responsible for generating QR codes and updating the database to confirm what numbers have been generated.

See the examples in spec/feature for specifics on how to interact with the library from a host application.

### Configuration

Most of the features must be configured for the specific application that uses the label generator.


#### Database

The model uses DataMapper, so any database compatable with DataMapper can be configured

#### QR URL

If a URL will be encoded in the QR Code, then the form of the URL must be specified inconfiguration

#### Seed number

The number that the sequence starts with is based on a configuration (but can be though of as a seed to the database).

If pre-existing assets are already accounted for, then just indicate the highest number in the sequence that has already been allocated to an asset.

#### Template

Templates are part of the LabelGen library. There is a default template to use for the labels,
but that setting can be changed. 

New templates can be pulled into the LabelGen library, or can be added to the correct load path.

## Testing

Run tests with colored and documented format:

    bundle exec rspec spec -c -fd

Run test examples that launch PDF output:

    bundle exec rspec spec -t launch

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
