lib_dir = File.expand_path('../../lib', __FILE__)

$:.unshift lib_dir

require 'chef'
require 'chef/knife'
require 'chef/knife/reporter_base'
require 'chef/knife/reporter_helpers'
require 'chef/knife/reporter_nodes_cli_report'
