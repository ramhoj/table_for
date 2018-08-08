module TableFor
  class TableBuilder < Struct.new(:table)
    delegate :template, :human_column_names, to: :table
    delegate :capture, :content_tag, to: :template

    def columns(*columns)
      head(*columns) + body(*columns)
    end

    def head(*columns)
      table.columns = columns

      content_tag(:thead) do
        content_tag(:tr) do
          human_column_names.map { |column| content_tag(:th, column) }.join.html_safe
        end
      end
    end

    def body(*columns, &block)
      content_tag(:tbody) do
        table.row_builders.map do |builder|
          if TableFor.row_filter.call(table, builder.record)
            content_tag(:tr) do
              if block then capture(builder, &block) else builder.cells(*columns) end
            end
          end
        end.compact.join.html_safe
      end
    end

    def foot(options={}, &block)
      if TableFor.footer_filter.call(table)
        content_tag(:tfoot) do
          content_tag(:tr) do
            if options[:align] == :right
              content_tag(:td, "", colspan: table.columns.size - 1) + content_tag(:td, capture(&block))
            else
              content_tag(:td, capture(&block), colspan: table.columns.size)
            end
          end
        end.html_safe
      end
    end
  end
end
