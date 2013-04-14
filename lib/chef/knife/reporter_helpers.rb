class Chef
  class Knife
    module ReporterHelper

      def self.nodes
        Chef::Search::Query.new.search(:node, '*:*')[0]
      end

      def self.extract_longest_string_from(collection)
        collection.reduce { |memo, word| memo.length > word.length ? memo : word }.length
      end

    end
  end
end
