require 'chef/knife/reporter_base'

class Chef
  class Knife
    class ReporterCli < Knife
      include Knife::ReporterBase

      banner 'knife reporter cli'

      def run
        report_nodes if @name_args[0].nil?
      end

      def report_nodes
        hostname_header  = extract_longest_string_from(nodes.map { |node| node.name })
        uptime_header    = extract_longest_string_from(nodes.map { |node| node.uptime })
        memory_header    = extract_longest_string_from(nodes.map { |node| (node.memory.total.to_i/1024).to_s })

        printf "%-#{hostname_header}s %-#{uptime_header}s %-#{memory_header}s %s\n", "Host Name", "Uptime", "Memory", "Run List"
        nodes.each do |node|
          printf "%-#{hostname_header}s %-#{uptime_header}s %-#{memory_header}s %s\n", node.name, node.uptime, "#{node.memory.total.to_i/1024}MB", node.run_list
        end
      end

      def nodes
        @nodes ||= Chef::Search::Query.new.search(:node, '*:*')[0]
      end

      def extract_longest_string_from(collection)
        collection.reduce { |memo, word| memo.length > word.length ? memo : word }.length+2
      end
    end
  end
end
