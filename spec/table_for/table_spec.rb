require 'spec_helper'

describe TableFor::Table do
  let(:template) { ActionView::Base.new }
  let(:users) do
    [TestTableFor::User.new(:first_name => "Nicklas", :last_name => "Ramhöj"),
     TestTableFor::User.new(:first_name => "Jonas", :last_name => "Nicklas")]
  end
  let(:table) { TableFor::Table.new(template, TestTableFor::User, users, lambda { "content" }) }
  before { table.stub(:columns).and_return([:first_name, :last_name]) }

  describe "#human_column_names" do
    it "returns a list with huminzed column names" do
      table.human_column_names.should == ["First name", "Last name"]
    end
  end

  describe "#row_builders" do
    it "returns a row builder for each record" do
      table.row_builders.map(&:class).should == [TableFor::RowBuilder, TableFor::RowBuilder]
    end
  end

  describe "#render" do
    it "wrapps the caption, header, body and footer in a table tag" do
      Capybara.string(table.render).should have_css "table.list caption", :text => "Users"
    end
  end
end