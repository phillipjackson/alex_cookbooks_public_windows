# Cookbook Name:: db_sqlserver
# Recipe:: restart_sql_service
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

# enable the SQL service
powershell "Restart the MSSQL Server" do
  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
    $sqlServiceName='MSSQL$SQLEXPRESS'
    $serviceController = get-service $sqlServiceName 2> $null
    if ($Null -eq $serviceController)
    {
        $sqlServiceName='MSSQLSERVER'
        $serviceController = get-service $sqlServiceName 2> $null
        if ($Null -eq $serviceController)
        {
            Write-Error "SQL Server service is not installed"
            exit 110
        }
    }

    if ($serviceController.Status -eq "Stopped")
    {
       net start $sqlServiceName
    }
    else
    {
        net stop $sqlServiceName
        net start $sqlServiceName
    }
POWERSHELL_SCRIPT

  source(powershell_script)
end
