require 'spec_helper'

describe TableFor::TableBuilder do
  let(:template) { ActionView::Base.new }
  let(:users) do
    [TestTableFor::User.new(:first_name => "Nicklas", :last_name => "Ramhöj"),
     TestTableFor::User.new(:first_name => "Jonas", :last_name => "Nicklas")]
  end
  let(:table) { TableFor::Table.new(template, TestTableFor::User, users, lambda { "content" }) }
  let(:table_builder) { TableFor::TableBuilder.new(table) }

  describe "#head" do
    subject { Capybara.string(table_builder.head(:name, :age)) }

    it "renders a thead with the header rows" do
      should have_css "thead tr", :text => "Name"
      should have_css "thead tr", :text => "Age"
    end
  end

  describe "#body" do
    subject { Capybara.string(table_builder.body(:first_name, :last_name)) }

    context "when the filter passes" do
      it "returns a tbody with the table rows" do
        should have_css "tbody tr", :text => "Nicklas"
        should have_css "tbody tr", :text => "Ramhöj"
        should have_css "tbody tr", :text => "Jonas"
      end
    end
  end

  describe "foot" do
    subject { Capybara.string(table_builder.foot { "footer content" }) }
    before { table.stub(:columns).and_return([:first_name, :last_name]) }

    context "when the filter passes" do
      it "returns a tfoot with the table rows" do
        should have_css "tfoot tr td", :text => "footer content"
      end

      it "returns sets a colspans equal to the number of columns" do
        should have_css "tfoot tr td[colspan='2']"
      end
    end
  end
end