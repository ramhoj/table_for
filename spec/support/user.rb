module TestTableFor
  class User < Struct.new(:first_name, :last_name)
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