# Cookbook Name:: win_aws
# Recipe:: put_file
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

# upload file to s3
win_aws_s3 "upload to s3" do
  access_key_id @node[:aws][:access_key_id]
  secret_access_key @node[:aws][:secret_access_key]
  s3_bucket @node[:s3][:bucket]
  file_path @node[:win_aws][:file_path]
  action :put
end
