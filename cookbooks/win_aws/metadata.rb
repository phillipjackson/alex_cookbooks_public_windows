maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Amazon Web Services recipes and providers for Windows"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.5"


recipe "win_aws::default", "Not implemented"
recipe "win_aws::install_dotnet_sdk", "Install Amazon Web Services SDK for .NET"
recipe "win_aws::do_register_instance_with_elb", "Register the instance with an Elastic Load Balancer created in the same ec2 region. Requires recipe: 'win_aws::install_dotnet_sdk'"
recipe "win_aws::do_deregister_instance_from_elb", "Deregister the instance with an Elastic Load Balancer created in the same ec2 region. Requires recipe: 'win_aws::install_dotnet_sdk'"
recipe "win_aws::get_file", "Retrieves a file from an S3 bucket"
recipe "win_aws::put_file", "Uploads a file to an S3 bucket"


attribute "aws/access_key_id",
  :display_name => "Access Key Id",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve you access identifiers. Ex: 1JHQQ4KVEVM02KVEVM02",
  :recipes => ["win_aws::do_register_instance_with_elb", "win_aws::do_deregister_instance_from_elb", "win_aws::get_file", "win_aws::put_file"],
  :required => "required"
  
attribute "aws/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve your access identifiers. Ex: XVdxPgOM4auGcMlPz61IZGotpr9LzzI07tT8s2Ws",
  :recipes => ["win_aws::do_register_instance_with_elb", "win_aws::do_deregister_instance_from_elb", "win_aws::get_file", "win_aws::put_file"],
  :required => "required"
  
attribute "aws/elb_name",
  :display_name => "ELB Name",
  :description => "The name of the Elastic Load Balancer to register/deregister the instance with. (e.g., production-elb). The ELB needs to be created and configured prior to the execution of the recipe.",
  :recipes => ["win_aws::do_register_instance_with_elb", "win_aws::do_deregister_instance_from_elb"],
  :required => "required"

attribute "win_aws/file_path",
  :display_name => "File Path",
  :description => "The full path to the file to be uploaded. Ex: c:\\tmp\\my.txt",
  :recipes => ["win_aws::put_file"],
  :required => "required"
  
attribute "s3/file",
  :display_name => "File",
  :description => "File to be retrieved from the s3 bucket. Ex: app.zip",
  :recipes => ["win_aws::get_file"],
  :required => "required"

attribute "s3/bucket",
  :display_name => "Bucket",
  :description => "The name of the S3 bucket",
  :recipes => ["win_aws::get_file", "win_aws::put_file"],
  :required => "required"
  
attribute "win_aws/download_dir",
  :display_name => "Download Dir",
  :description => "The directory where the file from s3 will be downloaded. Ex: c:\\tmp\\",
  :recipes => ["win_aws::get_file"],
  :required => "required"
