require 'active_admin/resource'

module ActiveAdmin
  class Resource
    class BelongsTo

      class TargetNotFound < StandardError
        def initialize(key, namespace)
          super "Could not find #{key} in #{namespace.name} " +
                "with #{namespace.resources.map(&:resource_name)}"
        end
      end

      # The resource which initiated this relationship
      attr_reader :owner

      def initialize(owner, target_name, options = {})
        @owner, @target_name, @options = owner, target_name, options
      end

      # Returns the target resource class or raises an exception if it doesn't exist
      def target
        key = @target_name.to_s.camelize
        namespace.resources[key] or raise TargetNotFound.new key, namespace
      end

      def namespace
        @owner.namespace
      end

      def optional?
        @options[:optional]
      end

      def required?
        !optional?
      end
    end
  end
end
