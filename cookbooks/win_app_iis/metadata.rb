maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "IIS recipes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.3"

depends 'win_aws' 

recipe "win_app_iis::default", "Not yet implemented"
recipe "win_app_iis::get_file", "Retrieves a file from an S3 bucket"
recipe "win_app_iis::put_file", "Uploads a file to an S3 bucket"

attribute "s3/file",
  :display_name => "File",
  :description => "File to be retrieved",
  :recipes => ["win_app_iis::get_file"]
  
attribute "s3/file",
  :display_name => "File",
  :description => "Name of the file on s3. When ignored, it will use the name in the File Path",
  :recipes => ["win_app_iis::put_file"],
  :required => false

attribute "s3/bucket",
  :display_name => "Bucket",
  :description => "The name of the S3 bucket",
  :recipes => ["win_app_iis::get_file", "win_app_iis::put_file"]
  
attribute "aws/access_key_id",
  :display_name => "Access Key Id",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve you access identifiers. Ex: 1JHQQ4KVEVM02KVEVM02",
  :recipes => ["win_app_iis::get_file", "win_app_iis::put_file"]
  
attribute "aws/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "This is an Amazon credential.  Log in to your AWS account at aws.amazon.com to retrieve your access identifiers. Ex: XVdxPgOM4auGcMlPz61IZGotpr9LzzI07tT8s2Ws",
  :recipes => ["win_app_iis::get_file", "win_app_iis::put_file"] 
  
attribute "win_app_iis/download_dir",
  :display_name => "Download Dir",
  :description => "The directory where the file from s3 will be downloaded. Ex: c:\\tmp\\",
  :recipes => ["win_app_iis::get_file"]
  
attribute "win_app_iis/file_path",
  :display_name => "File Path",
  :description => "The full path to the file to be uploaded. Ex: c:\\tmp\\my.txt",
  :recipes => ["win_app_iis::put_file"]
  
  