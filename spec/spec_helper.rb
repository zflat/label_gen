SPEC_TMP_PATH = File.join(File.dirname(__FILE__), 'tmp')

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
require 'launchy'
require 'label_gen'


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    # remove existing temp files from previous runs
    `rm -r #{File.join(SPEC_TMP_PATH, '*.pdf')} > /dev/null`
  end
end
