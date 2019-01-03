# frozen_string_literal: true

module TableFor
  class Table < Struct.new(:template, :model_class, :records, :html, :block)
    attr_accessor :columns, :rows
    delegate :capture, :content_tag, to: :template

    def human_column_names
      columns.map { |column| model_class.human_attribute_name(column) }
    end

    def row_builders
      records.map { |record| RowBuilder.new(self, record) }
    end

    def render
      builder = TableBuilder.new(self)
      body = block ? capture(builder, &block) : builder

      content_tag(:table, caption + body, class: css_class)
    end

    protected

    def css_class
      [human_association_name.downcase, "list", extra_css_class].compact
    end

    def extra_css_class
      html[:class].is_a?(String) ? html[:class].split : html[:class]
    end

    def caption
      content_tag(:caption, human_association_name)
    end

    def human_association_name
      model_class.model_name.human.pluralize
    end
  end
end
