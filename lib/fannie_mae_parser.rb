require 'fannie_mae_parser/version'
require 'fannie_mae_parser/document/factory'
require 'active_support'

module FannieMaeParser
  # full_path => document full_path filename
  def self.process(full_path)
    FannieMaeParser::Document::Factory.process(full_path)
  end
end
