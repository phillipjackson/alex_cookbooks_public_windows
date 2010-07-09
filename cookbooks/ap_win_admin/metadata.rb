maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Windows Admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.10"

recipe "ap_win_admin::default", "Not yet implemented"
recipe "ap_win_admin::change_admin_password", "Changes the administrator password"
recipe "ap_win_admin::system_reboot", "Reboots the system"
recipe "ap_win_admin::system_shutdown", "Shuts down the system"
recipe "ap_win_admin::install_firefox", "Installs Mozilla Firefox 3.6"
recipe "ap_win_admin::install_7zip", "Installs 7-Zip"
recipe "ap_win_admin::install_ruby", "Installs Ruby"
recipe "ap_win_admin::patched_start_default_website", "Starts the website named 'Default Web Site' if it is not already running" 

attribute "ap_win_admin/admin_password",
  :display_name => "New administrator password",
  :description => "New administrator password",
  :recipes => ["ap_win_admin::change_admin_password"]
