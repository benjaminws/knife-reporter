require 'ostruct'
require_relative('../../../spec_helper')

describe Chef::Knife::ReporterCli do

  before(:each) do
    subject.stub(:printf)
  end

  describe "#run" do
    context "when requesting a report on the command line" do
      before(:each) do
        subject.stub(:report_nodes)
      end

      it "call Knife::ReporterCli.report_nodes" do
        subject.should_receive(:report_nodes).once
        subject.run
      end
    end
  end

  describe "#report_nodes" do
    before(:each) do
      node = OpenStruct.new(:name => "node-name",
                            :uptime => "01:58:05 up 1 day, 15:36,  3 users,  load average: 0.10, 0.21, 0.22",
                            :memory => OpenStruct.new(:total => 3753))

      subject.stub(:nodes).and_return([node])
    end
    context "when requesting a report about the known nodes" do
      it "request the nodes 4 times" do
        subject.should_receive(:nodes).exactly(4).times
        subject.report_nodes
      end

      it "request the longest string to calculate formatting 3 times" do
        subject.should_receive(:extract_longest_string_from).exactly(3).times
        subject.report_nodes
      end

      it "call printf twice to output the report" do
        subject.should_receive(:printf).twice
        subject.report_nodes
      end
    end
  end

  describe "#extract_longest_string_from" do
    context "to help generate a tabular report" do
      it "return the longest node-name in a collection, plus 2 for padding" do
        collection = ["test", "testing"]
        subject.extract_longest_string_from(collection).should == 9
      end
    end
  end

  describe "#nodes" do
    before(:each) do
      node = OpenStruct.new(:name => "node-name",
                            :uptime => "01:58:05 up 1 day, 15:36,  3 users,  load average: 0.10, 0.21, 0.22",
                            :memory => OpenStruct.new(:total => 3753))

      double("Chef::Search::Query")
      Chef::Search::Query.stub_chain(:new, :search).and_return([node])
    end

    context "when node data is need from the chef server" do
      it "only actually request the data once" do
        Chef::Search::Query.new.should_receive(:search).once
        subject.nodes
      end
    end
  end
end
