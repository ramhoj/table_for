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

    class Table < Struct.new(:template, :model_class, :records, :block)
      attr_accessor :columns, :rows
      delegate :capture, :content_tag, :to => :template

      def human_association_name
        model_class.model_name.human.pluralize
      end

      def human_column_names
        columns.map { |column| model_class.human_attribute_name(column) }
      end

      def row_builders
        records.map { |record| RowBuilder.new(self, record) }
      end

      def render
        content_tag(:table, :class => 'list') do
          content_tag(:caption, human_association_name) + capture(TableBuilder.new(self), &block)
        end
      end
    end

    class TableBuilder < Struct.new(:table)
      delegate :template, :human_column_names, :to => :table
      delegate :capture, :content_tag, :admin?, :to => :template

      def columns(*columns)
        head(*columns) + body(*columns)
      end

      def head(*columns)
        table.columns = columns

        content_tag(:thead) do
          content_tag(:tr) do
            human_column_names.map { |column| content_tag(:th, column) }.join
          end
        end.html_safe
      end

      def body(*columns, &block)
        content_tag(:tbody) do
          table.row_builders.map do |builder|
            content_tag(:tr) do
              if block then capture(builder, &block) else builder.cells(*columns) end
            end
          end.join.html_safe
        end
      end

      def foot(&block)
        if admin?
          content_tag(:tfoot) do
            content_tag(:tr) do
              content_tag(:td, capture(&block), :colspan => table.columns.size)
            end
          end.html_safe
        end
      end
    end

    class RowBuilder < Struct.new(:table, :record)
      delegate :template, :to => :table
      delegate :content_tag, :to => :template

      def cells(*values)
        values.map { |v| cell(v) }.join.html_safe
      end

      def cell(value)
        content_tag(:td) do
          if value.is_a?(Symbol) then record.send(value).to_s else value.to_s end
        end
      end
    end
  end
end

ActionView::Base.send :include, TableFor::Helper