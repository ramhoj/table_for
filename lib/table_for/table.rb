module TableFor
  class Table < Struct.new(:template, :model_class, :records, :block)
    attr_accessor :columns, :rows
    delegate :capture, :content_tag, :to => :template

    def human_column_names
      columns.map { |column| model_class.human_attribute_name(column) }
    end

    def row_builders
      records.map { |record| RowBuilder.new(self, record) }
    end

    def render
      content_tag(:table, :class => 'list') do
        caption + capture(TableBuilder.new(self), &block)
      end
    end

  protected

    def caption
      content_tag(:caption, human_association_name)
    end

    def human_association_name
      model_class.model_name.human.pluralize
    end
  end
end