require 'chef/knife/reporter_base'

class Chef
  class Knife
    class ReporterNodesCli < Knife
      include Knife::ReporterBase

      banner 'knife reporter nodes cli'

      def run
        report_nodes if @name_args[0].nil?
      end

      def report_nodes
        nodes = Knife::ReporterHelper.nodes
        hostname_header  = Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| node.name })+2
        memory_header    = Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| (node.memory.total.to_i/1024).to_s })+2

        printf "%-#{hostname_header}s %-#{memory_header}s %s\n", "Host Name", "Memory", "Run List"
        nodes.each do |node|
          printf "%-#{hostname_header}s %-#{memory_header}s %s\n", node.name, "#{node.memory.total.to_i/1024}MB", node.run_list
        end
      end

    end
  end
end
