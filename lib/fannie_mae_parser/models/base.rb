require 'active_model'
require 'active_record'
require 'activerecord-tableless'
require 'fannie_mae_parser/modules/log_prefix'

module FannieMaeParser
  module Models

    class Base < ActiveRecord::Base
      include FannieMaeParser::Modules::LogPrefix

      # NOTE: DO NOT REMOVE THIS. Only having this in the parent class causes data issues.
      has_no_table

      attr_accessor :feed, :line

      # column :line, :string

      before_validation :handle_before_validation
      after_validation :handle_after_validation

      def self.create(feed, line=nil)
        m = new(feed: feed) do |model|
          if line.nil?
            model.line = feed.readline
            while model.line[0] == '#'
              model.line = feed.readline
            end
          else
            model.line = line
          end
        end

        m.parse

        m
      end

      # override in your SubClass
      #  when ready to parse the feed
      def parse
        self
      end

      private

      def handle_before_validation
        # override in SubClass to handle data preparation
      end

      def handle_after_validation
        # override in SubClass to handle setting
        #  of active_model error keys to match
        #  the payload fields
      end

      def field_range(options)
        return options[:first], options[:first] + options[:len]
      end

      def field_parse(options)
        first, last = field_range(options)
        line[first...last]
      end

      def set_attr(attr, options)
        field = field_parse(options)
        log_method { "#{attr}='#{field}'" }

        send("#{attr}=", field)
      end

      def fields
        self.class.fields
      end

      def parse_line
        fields.each do |attr, range|
          set_attr(attr, range)
        end
      end
    end
  end
end
