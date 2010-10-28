# Cookbook Name:: db_sqlserver
# Recipe:: enable_sql_mixed_mode_authentication
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

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

