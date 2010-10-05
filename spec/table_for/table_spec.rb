require 'spec_helper'

describe TableFor::Table do
  let(:template) { ActionView::Base.new }
  let(:users) do
    [TestTableFor::User.new(:first_name => "Nicklas", :last_name => "Ramhöj"),
     TestTableFor::User.new(:first_name => "Jonas", :last_name => "Nicklas")]
  end
  subject { TableFor::Table.new(template, TestTableFor::User, users, lambda { "content" }) }
  before { subject.stub(:columns).and_return([:first_name, :last_name]) }

  describe "#human_column_names" do
    it "returns a list with huminzed column names" do
      subject.human_column_names.should == ["First name", "Last name"]
    end
  end

  describe "#row_builders" do
    it "returns a row builder for each record" do
      subject.row_builders.map(&:class).should == [TableFor::RowBuilder, TableFor::RowBuilder]
    end
  end

  describe "#render" do
    it "wrapps the caption, header, body and footer in a table tag" do
      subject.render.should include(%Q{<table class="list">})
      subject.render.should include(%Q{<caption>Users</caption>})
      subject.render.should include(%Q{</table>})
    end
  end

  describe "#human_association_name" do
    it "returns the collection name" do
      subject.send(:human_association_name).should == "Users"
    end
  end

  describe "#caption" do
    it "wraps the human_association_name in a caption tag" do
      subject.send(:caption).should == "<caption>Users</caption>"
    end
  end
end