# Cookbook Name:: ap_elb
# Recipe:: add_to_elb
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

powershell "Register instance with the ELB" do
  chef_attribute = Chef::Node::Attribute.new(
                      {'ELB_NAME' => @node[:aws][:elb_name],
                       'AWS_ACCESS_KEY_ID' => @node[:aws][:access_key_id],
                       'AWS_SECRET_ACCESS_KEY' => @node[:aws][:secret_access_key]},
                      {},
                      {})
  parameters(chef_attribute)

  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
    Add-Type -Path "C:\Program Files\AWS SDK for .NET\bin\AWSSDK.dll"
    #...
POWERSHELL_SCRIPT

  source(powershell_script)
end
