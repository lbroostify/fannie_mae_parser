$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start  do
  add_group 'Document', 'lib/fannie_mae_parser/document'
end

require 'fannie_mae_parser'
require File.expand_path('spec/support/test_helper.rb')