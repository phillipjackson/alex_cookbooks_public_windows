# Cookbook Name:: ap_win_admin
# Recipe:: change_admin_password
#
# Copyright 2010, RightScale, Inc.
#
# All rights reserved

# change admin password
powershell "Changes the administrator password" do
  parameters({'ADMIN_PASSWORD' => @node[:ap_win_admin][:admin_password]})

  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
    net user administrator "$env:ADMIN_PASSWORD"
POWERSHELL_SCRIPT

  source(powershell_script)
end