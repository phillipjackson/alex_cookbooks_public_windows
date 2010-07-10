# Cookbook Name:: win_aws
# Recipe:: register_instance_with_elb
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved
#

# register instance with elb
win_aws_powershell_elbprovider "register instance" do
  access_key_id @node[:aws][:access_key_id]
  secret_access_key @node[:aws][:secret_access_key]
  s3_bucket @node[:aws][:elb_name]
  action :register
end