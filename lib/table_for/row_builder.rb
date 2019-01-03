# frozen_string_literal: true

module TableFor
  class RowBuilder < Struct.new(:table, :record)
    delegate :template, to: :table
    delegate :content_tag, to: :template

    def cells(*values)
      values.map { |v| cell(v) }.join.html_safe
    end

    def cell(value, options = {})
      content_tag(:td, options) do
        value.is_a?(Symbol) ? record.send(value).to_s : value.to_s
      end
    end
  end
end
