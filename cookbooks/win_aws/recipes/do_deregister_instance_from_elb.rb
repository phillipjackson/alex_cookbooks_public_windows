# Cookbook Name:: win_aws
# Recipe:: do_deregister_instance_from_elb
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved
#

# deregister instance from elb
win_aws_elbprovider "deregister instance provider call" do
  access_key_id @node[:aws][:access_key_id]
  secret_access_key @node[:aws][:secret_access_key]
  elb_name @node[:aws][:elb_name]
  action :deregister
end