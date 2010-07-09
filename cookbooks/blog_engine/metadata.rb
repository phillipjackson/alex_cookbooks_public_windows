maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "AP: Install and configure the BlogEngine application, see http://www.dotnetblogengine.net"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.3.4"

depends 'ap_win_admin'
depends 'win_aws'

recipe 'blog_engine::default', 'AP: Loads the database and installs the BlogEngine application as the default IIS site'
recipe "blog_engine::backup_database", "Backs up the BlogEngine database to a local machine directory."
recipe "blog_engine::backup_database_to_s3", "Backs up the BlogEngine database to a local machine directory."
recipe "blog_engine::restore_database", "Restores the BlogEngine database from a local machine directory."
recipe "blog_engine::drop_database", "Drops the BlogEngine database."
recipe "blog_engine::svn_code_checkout", "Retrieves code from SVN."
recipe "blog_engine::continuous_backup_database_to_s3", "Schedules continuous database backups to an s3 bucket. It requires the 'win_admin::change_admin_password' recipe in order to run the scheduled task under the administrator user."



attribute "db_sqlserver/server_name",
  :display_name => "SQL Server instance network name",
  :description => "The network name of the SQL Server instance used by recipes.",
  :default => "localhost\\SQLEXPRESS",
  :recipes => ["blog_engine::default", "blog_engine::backup_database", "blog_engine::backup_database_to_s3", "blog_engine::restore_database", "blog_engine::drop_database"]

attribute "db_sqlserver/backup/database_backup_dir",
  :display_name => "SQL Server backup .bak directory",
  :description => "The local drive path or UNC path to the directory which will contain new SQL Server database backup (.bak) files. Note that network drives are not supported by SQL Server.",
  :default => "c:\\datastore\\sqlserver\\databases",
  :recipes => ["blog_engine::backup_database", "blog_engine::backup_database_to_s3", "blog_engine::restore_database"]

attribute "db_sqlserver/backup/backup_file_name_format",
  :display_name => "Backup file name format",
  :description => "Format string with Powershell-style string format arguments for creating backup files. The 0 argument represents the database name and the 1 argument represents a generated time stamp.",
  :default => "{0}_{1}.bak",
  :recipes => ["blog_engine::default", "blog_engine::backup_database", "blog_engine::backup_database_to_s3", "blog_engine::restore_database"]

attribute "db_sqlserver/backup/existing_backup_file_name_pattern",
  :display_name => "Pattern matching backup file names",
  :description => "Wildcard file matching pattern (i.e. not a Regex) with Powershell-style string format arguments for finding backup files. The 0 argument represents the database name and the rest of the pattern should match the file names generated from the backup_file_name_format.",
  :default => "{0}_*.bak",
  :recipes => ["blog_engine::default", "blog_engine::backup_database", "blog_engine::backup_database_to_s3", "blog_engine::restore_database"]
  
attribute "s3/file",
  :display_name => "File",
  :description => "File to be retrieved",
  :recipes => ["blog_engine::default"],
  :required => true

attribute "s3/bucket",
  :display_name => "Bucket",
  :description => "The name of the S3 bucket",
  :recipes => ["blog_engine::default"],
  :required => true
  
attribute "aws/access_key_id",
  :display_name => "Access Key Id",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve you access identifiers. Ex: 1JHQQ4KVEVM02KVEVM02",
  :recipes => ["blog_engine::default"],
  :required => true
  
attribute "aws/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "This is an Amazon credential.  Log in to your AWS account at aws.amazon.com to retrieve your access identifiers. Ex: XVdxPgOM4auGcMlPz61IZGotpr9LzzI07tT8s2Ws",
  :recipes => ["blog_engine::default"],
  :required => true
  
attribute "database/backup/hourly_frequency",
  :display_name => "Backup hourly frequency",
  :description => "Defines the backup frequency in hours. Valid values: 1 up to 24. When 24 is specified the 'Backup daily time' input is required also.",
  :recipes => ["blog_engine::continuous_backup_database_to_s3"],
  :default => "4",
  :required => "recommended"
  
attribute "database/backup/daily_time",
  :display_name => "Backup daily time",
  :description => "The time of the day, based on the server's timezone, to run the backups when the 'Backup hourly frequency' input is set to 24. Format: hh:mm (Ex: 22:30)",
  :default => "04:00",
  :recipes => ["blog_engine::continuous_backup_database_to_s3"],
  :required => false