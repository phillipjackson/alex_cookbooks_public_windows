maintainer       "RightScale, Inc."
maintainer_email "alex@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Windows Admin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe "ap_test::default", "Not yet implemented"
recipe "ap_test::ps1_exec", "Executes a powershell script"
recipe "ap_test::dump_input", "Dumpes an input to c:\dump_input.txt"

attribute "dump/input",
  :display_name => "Input to dump",
  :description => "Input to dump",
  :recipes => ["ap_test::dump_input"]
