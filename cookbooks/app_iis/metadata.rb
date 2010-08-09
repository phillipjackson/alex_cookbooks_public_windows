maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "IIS recipes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.4"

depends 'aws'

recipe "app_iis::default", "Calls app_iis::update_code"
recipe "app_iis::update_code", "Retrieves code from SVN then sets up website."
recipe "app_iis::start_default_website", "Starts the website named 'Default Web Site' if it is not already running"



attribute "svn/repo_path",
  :display_name => "SVN Repo Path",
  :description => "The URL of your SVN repository where your application code will be checked out from.  Ex: http://mysvn.net/app/",
  :recipes => ["app_iis::update_code"],
  :required => "required"

attribute "svn/username",
  :display_name => "SVN Username",
  :description => "The SVN username that is used to checkout the application code from SVN repository",
  :recipes => ["app_iis::update_code"],
  :required => "optional",
  :default => ""

attribute "svn/password",
  :display_name => "SVN Password",
  :description => "The SVN password that is used to checkout the application code from SVN repository.",
  :recipes => ["app_iis::update_code"],
  :required => "optional",
  :default => ""

attribute "svn/force_checkout",
  :display_name => "SVN Force Checkout",
  :description => "A value of 'false' will attempt an svn update where 'true' will do a full checkout",
  :recipes => ["app_iis::update_code"],
  :choice => ['true', 'false'],
  :required => "required"
