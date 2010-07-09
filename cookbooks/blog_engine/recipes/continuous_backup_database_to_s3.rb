# Cookbook Name:: blog_engine
# Recipe:: continuous_backup_database_to_s3
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

if (@node[:database][:backup][:hourly_frequency].nil?)
  @node[:database][:backup][:hourly_frequency]=""
end

if (@node[:database][:backup][:daily_time].nil?)
  @node[:database][:backup][:daily_time]=""
end

if (@node[:win_admin][:admin_password].nil?)
  Chef::Log.error("*** This recipe requires the 'win_admin::change_admin_password' recipe in order to run the scheduled task under the administrator user")
  exit 1
end

powershell "Scheduling continuous database backups to s3" do
  parameters({'HOURLY_FREQ' => @node[:database][:backup][:hourly_frequency], 'DAILY_TIME' => @node[:database][:backup][:daily_time], 'ADMIN_PASSWORD' => @node[:win_admin][:admin_password]})

  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
  # "Stop" or "Continue" the powershell script execution when a command fails
  $ErrorActionPreference = "Stop"

  Write-Output "*** Converting hourly frequency [$env:HOURLY_FREQ] into an integer."  
  $num=[int]$env:HOURLY_FREQ
  
  if (!(Test-Path c:\tmp))
  {
    New-Item c:\tmp -type directory
  }

  $log_file="c:\tmp\continuous_backup_database_log.txt"
  
  if ($num -ge 1 -and $num -le 23)
  {
    Write-Output "*** Setting backups with hourly frequency [$num]"
    schtasks.exe /Create /F /SC HOURLY /MO $num /RU administrator /RP $env:ADMIN_PASSWORD /TN rs_db_continous_backup /TR "rs_run_recipe.cmd -v -n blog_engine::backup_database_to_s3 >>$log_file 2>&1 & echo at: %time% [%date%] >>$log_file 2>&1"  
  }
  elseif ($num -eq 24)
  {
    $time = $env:DAILY_TIME
    if (!($time -match "^[0-2]\d:[0-5]\d$"))
    {
      Write-Error "*** The 'Backup daily time' input[$time] is incorrect. Please use the 'hh:mm' format."
      exit 123
    }
    Write-Output "*** Setting daily backups at [$num]"
    schtasks.exe /Create /F /SC DAILY /ST $time /RU administrator /RP $env:ADMIN_PASSWORD /TN rs_db_continous_backup /TR "rs_run_recipe.cmd -v -n blog_engine::backup_database_to_s3 >>$log_file 2>&1 & echo at: %time% [%date%] >>$log_file 2>&1"
  }
  else
  {
    Write-Error "*** Hourly frequency is not between 1 and 24, aborting..."
    exit 124
  }

  schtasks.exe /Query /TN rs_db_continous_backup
POWERSHELL_SCRIPT

  #execute the powershell script
  source(powershell_script)
end
