require_relative "validation"
# ... Add "require" statements for your own helpers here ...

# Register helpers with Sinatra
helpers do
  # This is so that we get to use the "h" method in views
  include ERB::Util

  # This is so that we include useful validation methods
  include Validation

  # ... Add your own helper modules here ...
end
