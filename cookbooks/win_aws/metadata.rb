maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Amazon Web Services recipes and providers for Windows"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.4"


recipe "win_aws::default", "Not implemented"
recipe "win_aws::install_dotnet_sdk", "Install Amazon Web Services SDK for .NET"
recipe "win_aws::register_instance_with_elb", "Register the instance with an Elastic Load Balancer created in the same ec2 region. Requires recipe: 'win_aws::install_dotnet_sdk'"
recipe "win_aws::deregister_instance_from_elb", "Deregister the instance with an Elastic Load Balancer created in the same ec2 region. Requires recipe: 'win_aws::install_dotnet_sdk'"


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
  :description => "The name of the Elastic Load Balancer to register/deregister the instance with. (e.g., production-elb). The ELB needs to be created and configured prior to the execution of the recipe.",
  :recipes => ["win_aws::register_instance_with_elb", "win_aws::deregister_instance_from_elb"],
  :required => true
