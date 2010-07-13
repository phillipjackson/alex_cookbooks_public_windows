# Cookbook Name:: win_aws
# Recipe:: do_register_instance_with_elb
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved
#

# register instance with elb
win_aws_powershell_elbprovider "register instance provider call" do
  access_key_id @node[:aws][:access_key_id]
  secret_access_key @node[:aws][:secret_access_key]
  elb_name @node[:aws][:elb_name]
  action :register
end