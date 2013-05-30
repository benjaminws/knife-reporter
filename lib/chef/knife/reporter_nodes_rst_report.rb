require 'chef/knife/reporter_base'

class Chef
  class Knife
    class ReporterNodesRst < Knife
      include Knife::ReporterBase

      attr_accessor :nodes, :hostname_size, :memory_size, :runlist_size
      banner 'knife reporter nodes rst'

      option :output_file,
        :short => "-o FILE",
        :long  => "--outfile FILE",
        :description => "File to write the report to",
        :default => "./nodes.rst"

      def run
        report_nodes if @name_args[0].nil?
      end

      def report_nodes
        output_file = config[:output_file]

        node_table = []
        node_table << "Nodes deployed & managed by chef"
        node_table << "================================\n"
        node_table << table_row_seperator
        node_table << table_heading
        node_table << terminate_header_row

        nodes.each do |node|
          node_table << node_row_for(node)
          node_table << table_row_seperator
        end

        Log.debug "writing to #{output_file}"
        File.open(output_file, 'w') do |file|
          file.write(node_table.join("\n") + "\n")
        end
      end

      def nodes
        @nodes ||= Knife::ReporterHelper.nodes
      end

      def table_row_seperator
        "+#{'-' * (hostname_size+2)}+#{'-' * (memory_size+2)}+#{'-' * (runlist_size+2)}+"
      end

      def terminate_header_row
        "+#{'=' * (hostname_size+2)}+#{'=' * (memory_size+2)}+#{'=' * (runlist_size+2)}+"
      end

      def table_heading
        sprintf("| %-#{hostname_size}s | %-#{memory_size}s | %-#{runlist_size}s |", "Host Name", "Memory", "Run List")
      end

      def runlist_size
        @runlist_size ||= Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| node.run_list.to_s })
      end

      def memory_size
        @memory_size ||= Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| (node.memory.total.to_i/1024).to_s })+2
      end

      def hostname_size
        @hostname_size ||= Knife::ReporterHelper.extract_longest_string_from(nodes.map { |node| node.name })+2
      end

      def node_row_for(node)
        sprintf("| %-#{hostname_size}s | %-#{memory_size}s | %-#{runlist_size}s |", node.name, "#{node.memory.total.to_i/1024}MB", node.run_list)
      end
    end
  end
end
