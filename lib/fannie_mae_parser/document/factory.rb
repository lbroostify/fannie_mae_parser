require 'fannie_mae_parser/document/base'

module FannieMaeParser
  module Document
    class Factory

      def self.process(full_path_to_doc)
        Base.new.process(full_path_to_doc)
      end
    end
  end
end