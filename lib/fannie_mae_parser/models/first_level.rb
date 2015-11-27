module FannieMaeParser
  module Models

    class FirstLevel < Models::Base
      FIELDS = {
        code:  {first: 0, len: 3},
        two:   {first: 10, len: 10},
      }
      # NOTE: DO NOT REMOVE THIS. Only having this in the parent class causes data issues.
      has_no_table

      column :code, :string
      column :two, :date
      column :top_level_id, :integer

      belongs_to :top_level

      validates :code, :two,
                presence: true

      validates :code, length: {is: 3}

      def self.fields
        FIELDS
      end

      def next_line
        if valid?
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
