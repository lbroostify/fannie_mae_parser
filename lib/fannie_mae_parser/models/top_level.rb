require 'fannie_mae_parser/models/base'
require 'fannie_mae_parser/models/first_level'

module FannieMaeParser
  module Models

    class TopLevel < Models::Base
      FIELDS = {
        code:  {first: 0, len: 3},
        two:   {first: 10, len: 10},
        three: {first: 20, len: 9},
        four:  {first: 30, len: 29},
        five:  {first: 60, len: 9}
      }

      # NOTE: DO NOT REMOVE THIS. Only having this in the parent class causes data issues.
      has_no_table

      column :code, :string
      column :two, :date
      column :three, :float
      column :four, :time
      column :five, :integer
      column :first_level_id, :integer

      has_one :first_level

      validates :code, :two,
                presence: true

      validates :code, length: {is: 3}

      def self.fields
        FIELDS
      end

      def next_line
        if valid?
          to_inspect

          if next_line = feed.readline
            case next_line[0...3]
              when '02B'
                self.first_level = FannieMaeParser::Models::FirstLevel.create(feed, next_line)
              when '03B'

            end

          end
        else
          puts "errors:#{errors.full_messages}"
        end
      end

      def parse
        log_method { "\n#{line}" }
        parse_line
        next_line
      end

    end
  end
end
