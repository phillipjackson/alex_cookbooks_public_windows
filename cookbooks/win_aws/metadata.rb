maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Amazon Web Services recipes and providers for Windows"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.4"


recipe "win_aws::default", "Not implemented"
recipe "win_aws::install_dotnet_sdk", "Install AWS SDK for .NET"
