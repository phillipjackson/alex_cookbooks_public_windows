# Cookbook Name:: blog_engine
# Recipe:: do_svn_code_checkout 
#
# Copyright (c) 2010 RightScale Inc
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#checkout code on first run, then update 
#https://wush.net/svn/rightscale/unified_test_app/dotnet/src
win_code_checkout_powershell_svnprovider "http://svn.github.com/alexpop/sample_www.git" do
  releases_path "c:\\inetpub\\releases"
  force_checkout false
  action :checkout
end

powershell "Change IIS physical path" do
  # Create the powershell script
  powershell_script = <<'POWERSHELL_SCRIPT'
  $checkoutpath=invoke-expression 'Get-ChefNode checkoutpath'
  
  if (Test-Path $checkoutpath)
  {
  
      # change the physicalPath for the IIS site
      $appcmd_path = $env:systemroot + "\\system32\\inetsrv\\APPCMD.exe"
      if (Test-Path $appcmd_path)
      {
        &$appcmd_path set SITE "Default Web Site" "/[path='/'].[path='/'].physicalPath:$checkoutpath"
      }
      else
      {
        Write-Error "***Error: APPCMD.EXE was not found, aborting" 
        exit 136
      }
  }
  else
  {
    Write-Error "***Error: Invalid physical path [$checkoutpath]" 
    exit 135
  }
POWERSHELL_SCRIPT

  source(powershell_script)
end
