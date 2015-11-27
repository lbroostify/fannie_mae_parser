require 'fannie_mae_parser/models/top_level'

module FannieMaeParser
  module Document
    class Base

      attr_accessor :file_path,
                    :line_number

      def initialize
        @feed = nil
      end

      def process(full_path_to_doc)
        @file_path = full_path_to_doc
        parse

        resource
      end

      private

      def parse_valid?
        if File.readable?(file_path)
          true
        else
          raise ArgumentError.new("document:'#{file_path}', does not exist.")
        end
      end

      def resource_klass
        CONFIG[@line.slice(0...3)]
      end

      def resource
        @resource ||= FannieMaeParser::Models::TopLevel.create(feed)
      end

      def parse
        if parse_valid?
          @line_number = 0
          puts 'parse this file'
          unless resource.valid?
            puts "#{resource.errors.full_messages}"
          end

          # feed.each_line do |line|
          #   parse_line(line)
          #   @line_number += 1
          # end

          feed.close
        end
      end

      def feed
        @feed ||= File.open(file_path, 'r')
      end

      def log_new_relic(ex)
        #Rails.logger.error("#{self.class.name}, rescue class:#{ex.class}, msg:#{ex.message}")
      end
    end
  end
end