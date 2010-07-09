# Cookbook Name:: ap_test
# Recipe:: ps1_exec
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

powershell "Executes a powershell script" do
  #source_file_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'files', 'ps1_exec', 'script.ps1'))
  #source(File::read(source_file_path))
  
  
  powershell_script = <<'POWERSHELL_SCRIPT'
  $aaa=dir c:/windows
  echo "finish"
POWERSHELL_SCRIPT

#test
  source(powershell_script)
end
