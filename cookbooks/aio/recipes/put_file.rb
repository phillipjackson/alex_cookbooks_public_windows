# Cookbook Name:: aio
# Recipe:: put_file
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved


# download
win_aws_powershell_s3providers "uploadmyfile" do
  access_key_id @node[:aws][:access_key_id]
  secret_access_key @node[:aws][:secret_access_key]
  s3_bucket @node[:s3][:bucket]
  s3_file @node[:s3][:file]
  file_path @node[:aio][:file_path]
  action :put
end
