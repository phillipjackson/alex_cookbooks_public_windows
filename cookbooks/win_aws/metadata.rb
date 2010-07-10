maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Amazon Web Services recipes and providers for Windows"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.4"


recipe "win_aws::default", "Not implemented"
recipe "win_aws::install_dotnet_sdk", "Install AWS SDK for .NET"

attribute "aws/access_key_id",
  :display_name => "Access Key Id",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve you access identifiers. Ex: 1JHQQ4KVEVM02KVEVM02",
  :recipes => ["win_aws::register_instance_with_elb", "win_aws::deregister_instance_from_elb"],
  :required => true
  
attribute "aws/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve your access identifiers. Ex: XVdxPgOM4auGcMlPz61IZGotpr9LzzI07tT8s2Ws",
  :recipes => ["win_aws::register_instance_with_elb", "win_aws::deregister_instance_from_elb"],
  :required => true
  
attribute "aws/elb_name",
  :display_name => "ELB Name",
  :description => "Defines the backup frequency in hours. Valid values: 1 up to 24. When 24 is specified the 'Backup daily time' input is required also.",
  :recipes => ["win_aws::register_instance_with_elb", "win_aws::deregister_instance_from_elb"],
  :required => true
