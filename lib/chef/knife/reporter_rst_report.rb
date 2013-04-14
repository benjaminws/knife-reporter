require 'chef/knife/reporter_base'
require 'pandoc-ruby'

class Chef
  class Knife
    class ReporterRst < Knife
      include Knife::ReporterBase

      banner 'knife reporter rst'

      def run
        report_nodes if @name_args[0].nil?
      end

      def report_nodes

      end
    end
  end
end
