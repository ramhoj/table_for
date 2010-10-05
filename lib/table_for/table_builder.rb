module TableFor
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
end