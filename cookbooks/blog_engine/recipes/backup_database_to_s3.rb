# Cookbook Name:: blog_engine
# Recipe:: backup_database_to_s3
#
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

# loads the demo database from cookbook-relative backup file.

blog_engine_powershell_database "app_test" do
  machine_type = @node[:kernel][:machine]
  backup_dir_path @node[:db_sqlserver][:backup][:database_backup_dir]
  backup_file_name_format @node[:db_sqlserver][:backup][:backup_file_name_format]
  existing_backup_file_name_pattern @node[:db_sqlserver][:backup][:existing_backup_file_name_pattern]
  server_name @node[:db_sqlserver][:server_name]
  force_restore false
  zip_backup true
  action :backup
end

#hack because image 5.4.3 is not setting @nodes properly in providers 
powershell "get the backupfilename name" do
  backupfromruby=`powershell ls \\inetpub\\releases`
  
  if (@node[:backupfilename].nil?)
    @node[:backupfilename]="app_test_20100714082428.bak.zip"
  end

end

  #upload dump to s3
  win_aws_powershell_s3provider "download mssql dump from bucket" do
    access_key_id @node[:aws][:access_key_id]
    secret_access_key @node[:aws][:secret_access_key]
    s3_bucket @node[:s3][:bucket_backups]
    s3_file @node[:backupfilename]
    file_path @node[:db_sqlserver][:backup][:database_backup_dir]+""+@node[:backupfilename]
    action :put
  end