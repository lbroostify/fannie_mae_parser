module FannieMaeParser
  module Modules
    module LogPrefix
      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:include, InstanceMethods)
      end

      module ClassMethods
        def debug_level?
          true
        end
      end

      module InstanceMethods
        def debug_level?
          self.class.debug_level?
        end

        def to_inspect
          if debug_level?
            self.class.columns.each do |col|
              value = send(col.name)
              puts "%8s %20s => '%s'" % [value.class.name, col.name, value]
            end
          end
        end

        # grab the method name from the caller stack
        #   based on position
        # when using blocks the position is 7 for the calling method
        def _caller_method(position=1)
          # caller.each_with_index do |c, i|
          #   puts "#{i}, #{c}"
          # end
          caller[position].match(/`.*?'/).to_s[1..-2]
        end

        def log_method
          if debug_level?
            who = "#{self.class.name}.#{_caller_method}"
            msg = yield if block_given?
            puts "#{who} #{msg}"
          end
        end

        def log_debug(&block)
          if debug_level?
            if block_given?
              puts yield
            end
          end
        end
      end
    end
  end
end