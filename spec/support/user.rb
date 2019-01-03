# frozen_string_literal: true

module TestTableFor
  class User
    attr_accessor :first_name, :last_name

    def initialize(attributes = {})
      @first_name = attributes[:first_name]
      @last_name = attributes[:last_name]
    end

    class << self
      def human_attribute_name(attribute)
        attribute.to_s.humanize
      end

      def model_name
        self
      end

      def human
        "User"
      end
    end
  end
end
