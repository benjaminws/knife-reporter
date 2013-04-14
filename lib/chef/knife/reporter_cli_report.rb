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
        nodes = Knife::ReporterHelper.nodes
        hostname_header  = Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| node.name })+2
        uptime_header    = Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| node.uptime })+2
        memory_header    = Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| (node.memory.total.to_i/1024).to_s })+2

        printf "%-#{hostname_header}s %-#{uptime_header}s %-#{memory_header}s %s\n", "Host Name", "Uptime", "Memory", "Run List"
        nodes.each do |node|
          printf "%-#{hostname_header}s %-#{uptime_header}s %-#{memory_header}s %s\n", node.name, node.uptime, "#{node.memory.total.to_i/1024}MB", node.run_list
        end
      end

    end
  end
end
