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


powershell "Scheduling continuous database backups" do
  #define the parameters to be sent to he powershell script
  parameters({'BACKUPFILE' => @node[:backupfile]})
  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
    # "Stop" or "Continue" the powershell script execution when a command fails
    $ErrorActionPreference = "Stop"
  
    echo "!backupfile-env is [$env:BACKUPFILE]"
  
    $getchefnode=invoke-expression 'Get-ChefNode backupfile'
    echo "!backup-getnode is [$getchefnode]"
POWERSHELL_SCRIPT

  #execute the powershell script
  source(powershell_script)
end