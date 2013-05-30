require 'ostruct'
require_relative('../../../spec_helper')

describe Chef::Knife::ReporterNodesCli do

  before(:each) do
    subject.stub(:printf)
  end

  let(:helpers) { Chef::Knife::ReporterHelper }

  describe "#run" do
    context "when requesting a report on the command line" do
      before(:each) do
        subject.stub(:report_nodes)
      end

      it "call Chef::Knife::ReporterNodesCli.report_nodes" do
        subject.should_receive(:report_nodes).once
        subject.run
      end
    end
  end

  describe "#report_nodes" do
    context "when requesting a report about the known nodes" do
      before(:each) do
        node = OpenStruct.new(:name => "node-name",
                              :uptime => "01:58:05 up 1 day, 15:36,  3 users,  load average: 0.10, 0.21, 0.22",
                              :memory => OpenStruct.new(:total => 3753))

        helpers.stub(:nodes).and_return([node])
      end

      it "request the nodes" do
        helpers.should_receive(:nodes).once
        subject.report_nodes
      end

      it "request the longest string to calculate formatting 3 times" do
        helpers.stub(:extract_longest_string_from)
        helpers.should_receive(:extract_longest_string_from).once.and_return(11)
        helpers.should_receive(:extract_longest_string_from).once.and_return(69)
        helpers.should_receive(:extract_longest_string_from).once.and_return(3)
        subject.report_nodes
      end

      it "call printf twice to output the report" do
        subject.should_receive(:printf).twice
        subject.report_nodes
      end
    end
  end
end
