require "table_for/helper"

module TableFor
  autoload :Table, "table_for/table"
  autoload :TableBuilder, "table_for/table_builder"
  autoload :RowBuilder, "table_for/row_builder"

  class << self
    def footer_filter(&block)
      @footer_filter = block if block
      @footer_filter
    end

    def row_filter(&block)
      @row_filter = block if block
      @row_filter
    end
  end
end

TableFor.footer_filter { |table| true }
TableFor.row_filter    { |table, record| true }
