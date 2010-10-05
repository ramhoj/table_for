module TableFor
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