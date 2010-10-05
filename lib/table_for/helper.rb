module TableFor
  module Helper
    # Create a table for records, using model class for naming things.
    #
    # Example:
    #
    # table_for User @users do |table|
    # table.columns :first_name, :last_name
    # end
    #
    def table_for(model_class, records, &block)
      Table.new(self, model_class, records, block).render
    end
  end
end

ActionView::Base.send :include, TableFor::Helper