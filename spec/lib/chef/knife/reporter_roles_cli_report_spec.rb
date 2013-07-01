require 'ostruct'
require_relative('../../../spec_helper')

describe Chef::Knife::ReporterRolesCli do

  before(:each) do
    subject.stub(:printf)
  end

  let(:helpers) { Chef::Knife::ReporterHelper }

  describe "#run" do
    context "when requesting a report on the command line" do
      before(:each) do
        subject.stub(:report_roles)
      end

      it "call Chef::Knife::ReporterRolesCli.report_role" do
        subject.should_receive(:report_roles).once
        subject.run
      end
    end
  end

  describe "#report_roles" do
    context "when requesting a report about the known roles" do
      before(:each) do
        role = OpenStruct.new(:name => "role",
                              :description => "role description")

        helpers.stub(:roles).and_return([role])
      end

      it "request the roles" do
        helpers.should_receive(:roles).once
        subject.report_roles
      end

      it "request the longest string to calculate formatting 2 times" do
        helpers.stub(:extract_longest_string_from)
        helpers.should_receive(:extract_longest_string_from).once.and_return(4)
        helpers.should_receive(:extract_longest_string_from).once.and_return(16)
        subject.report_roles
      end

      it "call printf twice to output the report" do
        subject.should_receive(:printf).twice
        subject.report_roles
      end
    end
  end
end
