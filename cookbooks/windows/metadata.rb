maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Windows Admin recipes and providers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.12"

recipe "windows::default", "Not yet implemented"
recipe "windows::do_change_admin_password", "Changes the administrator password"
recipe "windows::do_system_reboot", "Reboots the system"
recipe "windows::do_system_shutdown", "Shuts down the system"
recipe "windows::install_firefox", "Installs Mozilla Firefox 3.6"
recipe "windows::install_7zip", "Installs 7-Zip"
recipe "windows::install_ruby", "Installs Ruby"
recipe "windows::setup_scheduled_task_create", "Creates the 'rs_scheduled_task' scheduled task under the 'administrator' user. Uses the SCHTASKS Windows command"
recipe "windows::setup_scheduled_task_delete", "Deletes the 'rs_scheduled_task' scheduled task under the 'administrator' user. Uses the SCHTASKS Windows command"

attribute "windows/admin_password",
  :display_name => "New administrator password",
  :description => "New administrator password",
  :recipes => ["windows::do_change_admin_password", "windows::setup_scheduled_task_create"],
  :required => "required"

attribute "schtasks/command",
  :display_name => "Task command",
  :description => "Defines the shell command to run. (e.g., dir >> c:\\dir.txt)",
  :recipes => ["windows::setup_scheduled_task_create"],
  :required => "required"

attribute "schtasks/hourly_frequency",
  :display_name => "Task Hourly frequency",
  :description => "Defines the task frequency in hours. Valid values: 1 up to 24. When 24 is specified the 'Task daily time' input is required also.",
  :recipes => ["windows::setup_scheduled_task_create"],
  :required => "required"
  
attribute "schtasks/daily_time",
  :display_name => "Task daily time",
  :description => "The time of the day, based on the server's timezone, to run the task when the 'Hourly frequency' input is set to 24. Format: hh:mm (e.g., 22:30)",
  :recipes => ["windows::setup_scheduled_task_create"],
  :required => "optional",
  :default => ""
  
