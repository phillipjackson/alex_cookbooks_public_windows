# Cookbook Name:: db_sqlserver
# Recipe:: enable_sql_mixed_mode_authentication
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

if (@node[:db_sqlserver_enable_sql_mixed_mode_authentication_executed])
  Chef::Log.info("*** Recipe 'db_sqlserver::enable_sql_mixed_mode_authentication_executed' already executed, skipping...")
else
  # Create default user
  db_sqlserver_database @node[:db_sqlserver][:database_name] do
    server_name @node[:db_sqlserver][:server_name]
    commands ["EXECUTE master..xp_regwrite 'HKEY_LOCAL_MACHINE','SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10.MSSQLSERVER\\MSSQLServer',N'LoginMode',N'REG_DWORD',2;",
              "EXECUTE master..xp_regwrite 'HKEY_LOCAL_MACHINE','SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQL10.SQLEXPRESS\\MSSQLServer',N'LoginMode',N'REG_DWORD',2;"]
    action :run_command
  end
  
  include_recipe 'db_sqlserver::restart_sql_service'

  @node[:db_sqlserver_enable_sql_mixed_mode_authentication_executed] = true
end

