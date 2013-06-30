require 'chef/knife/reporter_base'

class Chef
  class Knife
    class ReporterRolesCli < Knife
      include Knife::ReporterBase

      banner 'knife reporter roles cli'

      def run
        report_roles if @name_args[0].nil?
      end

      def report_roles
        roles = Knife::ReporterHelper.roles
        name_header = Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.name})+2
        description_header = Knife::ReporterHelper.extract_longest_string_from(roles.map { |role| role.description})+2

        printf "%-#{name_header}s %-#{description_header}s %s\n", "Name", "Description", "Run List"
        roles.each do |role|
          printf "%-#{name_header}s %-#{description_header}s %s\n", role.name, role.description, role.run_list 
        end
      end

    end
  end
end
