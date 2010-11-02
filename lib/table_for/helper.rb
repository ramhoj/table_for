module TableFor
  module Helper
    # Create a html table for records, using model class for naming things.
    #
    # Examples:
    #
    # <tt>table_for Product, @products do |table|
    #   table.head :name, :size, :description, :price
    #   table.body do |row|
    #     row.cell :name
    #     row.cells :size, :description
    #     row.cell number_to_currency(row.record.price)
    #   end
    #   table.foot do
    #     link_to "Add product", new_product_path
    #   end
    # end</tt>
    #
    # <tt>table_for Product, @products do |table|
    #   table.columns :name, :size, :description, :price
    #   table.foot do
    #     link_to "Add product", new_product_path
    #   end
    # end</tt>
    #
    # Returns:
    #
    # A string containing the html table
    #
    # (Call this method from your erb templates by wrapping each line in <%= %> or <% %>)

    def table_for(model_class, records, html = {}, &block)
      Table.new(self, model_class, records, html, block).render
    end
  end
end

ActionView::Base.send :include, TableFor::Helper