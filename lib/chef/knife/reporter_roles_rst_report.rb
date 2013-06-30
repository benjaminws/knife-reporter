require 'chef/knife/reporter_base'

class Chef
  class Knife
    class ReporterRolesRst < Knife
      include Knife::ReporterBase

      attr_accessor :roles, :name_size, :description_size, :runlist_size
      banner 'knife reporter roles rst'

      option :output_file,
        :short => "-o FILE",
        :long  => "--outfile FILE",
        :description => "File to write the report to",
        :default => "./roles.rst"

      def run
        report_roles if @name_args[0].nil?
      end

      def roles
        @roles || Knife::ReporterHelper.roles
      end

      def report_roles
        output_file = config[:output_file]

        role_table = []
        role_table << "Roles employed by the chef server"
        role_table << "=================================\n"
        role_table << table_row_seperator
        role_table << table_heading
        role_table << terminate_header_row

        roles = Knife::ReporterHelper.roles
        name_header = Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.name})+2
        description_header = Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.description})+2

        roles.each do |role|
          role_table << role_row_for(role)
          role_table << table_row_seperator
        end

        Log.debug "weriting to #{output_file}"
        File.open(output_file, 'w') do |file|
          file.write(role_table.join("\n") + "\n")
        end
      end

      def table_row_seperator
        "+#{'-' * (name_size+2)}+#{'-' * (description_size+2)}+#{'-' * (runlist_size+2)}+"
      end

      def terminate_header_row
        "+#{'=' * (name_size+2)}+#{'=' * (description_size+2)}+#{'=' * (runlist_size+2)}+"
      end

      def table_heading
        sprintf("| %-#{name_size}s | %-#{description_size}s | %-#{runlist_size}s |", "Name", "Description", "Run List")
      end

      def runlist_size
        @runlist_size ||= Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.run_list.to_s })
      end

      def name_size
        @name_size ||= Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.name })+2
      end

      def description_size
        @hostname_size ||= Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.description })+2
      end

      def role_row_for(role)
        sprintf("| %-#{name_size}s | %-#{description_size}s | %-#{runlist_size}s |", role.name, role.description, role.run_list)
      end
    end
  end
end
