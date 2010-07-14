# Copyright (c) 2010 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if (@node[:boot_run])
  Chef::Log.info("*** Recipe 'blog_engine::default' already executed, skipping...")
else
  # download the sql dump
  win_aws_powershell_s3provider "download mssql dump from bucket" do
    access_key_id @node[:aws][:access_key_id]
    secret_access_key @node[:aws][:secret_access_key]
    s3_bucket @node[:s3][:bucket_dump]
    s3_file @node[:s3][:file]
    download_dir "c:\\tmp"
    action :get
  end

#  if (@node[:s3][:file] =~ /(.*)?\..*zip/)
#    file_prefix = $1
#    system("7z x -y \""+@node[:s3][:file]+"\"")
#  end

  # load the initial demo database from deployed SQL script.
  # no schema provided for this import call
  blog_engine_powershell_database "noschemayet" do
    server_name @node[:db_sqlserver][:server_name]
    script_path "c:\\tmp\\"+@node[:s3][:file]
    action :run_script
  end

  blog_engine_powershell_database "app_test" do
    server_name @node[:db_sqlserver][:server_name]
    commands ["CREATE USER [NetworkService] FOR LOGIN [NT AUTHORITY\\NETWORK SERVICE]",
              "EXEC sp_addrolemember 'db_datareader', 'NetworkService'",
              "EXEC sp_addrolemember 'db_datawriter', 'NetworkService'"]
    action :run_command
  end

  @node[:boot_run] = true
end
