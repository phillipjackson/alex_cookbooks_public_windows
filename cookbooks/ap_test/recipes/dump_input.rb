# Cookbook Name:: ap_test
# Recipe:: dump_input
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

# change admin password
powershell "Changes the administrator password" do
  chef_attribute = Chef::Node::Attribute.new(
                      {'DUMP_INPUT' => @node[:dump][:input]},
                      {},
                      {})
  parameters(chef_attribute)

  powershell_script = <<'POWERSHELL_SCRIPT'
    echo "$env:DUMP_INPUT" > c:/dump_input.txt
POWERSHELL_SCRIPT

  source(powershell_script)
end
