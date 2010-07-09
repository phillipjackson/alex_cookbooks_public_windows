maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "ELB recipes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.3"

recipe "ap_elb::default", "Not yet implemented"
recipe "ap_elb::add_to_elb", "Adds the instance to an Elastic Load Balancer"

attribute "aws/elb_name",
  :display_name => "ELB",
  :description => "The name of the Elastic Load Balancer",
  :recipes => ["ap_elb::add_to_elb"]
  
attribute "aws/access_key_id",
  :display_name => "Access Key Id",
  :description => "This is an Amazon credential. Log in to your AWS account at aws.amazon.com to retrieve you access identifiers. Ex: 1JHQQ4KVEVM02KVEVM02",
  :recipes => ["ap_elb::add_to_elb"]
  
attribute "aws/secret_access_key",
  :display_name => "Secret Access Key",
  :description => "This is an Amazon credential.  Log in to your AWS account at aws.amazon.com to retrieve your access identifiers. Ex: XVdxPgOM4auGcMlPz61IZGotpr9LzzI07tT8s2Ws",
  :recipes => ["ap_elb::add_to_elb"] 