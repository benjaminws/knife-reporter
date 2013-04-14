require 'ostruct'
require_relative('../../../spec_helper')

describe Chef::Knife::ReporterHelper do

  describe '#extract_longest_string_from' do
    context 'to help generate a tabular report' do
      it 'return the longest string in a collection' do
        collection = ['test', 'testing']
        subject.extract_longest_string_from(collection).should == 7
      end
    end
  end

  describe '#nodes' do
    before(:each) do
      node = OpenStruct.new(:name => 'node-name',
                            :uptime => '01:58:05 up 1 day, 15:36,  3 users,  load average: 0.10, 0.21, 0.22',
                            :memory => OpenStruct.new(:total => 3753))

      double('Chef::Search::Query')
      Chef::Search::Query.stub_chain(:new, :search).and_return([node])
    end

    context 'when node data is need from the chef server' do
      it 'will request the data from the chef api' do
        Chef::Search::Query.new.should_receive(:search).once
        subject.nodes
      end
    end
  end

end
