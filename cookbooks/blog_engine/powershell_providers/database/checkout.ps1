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

# locals.
$svnPath = Get-NewResource name
$svnUsername = Get-NewResource svn_username
$svnPassword = Get-NewResource svn_password

$forceCheckout = Get-NewResource force_checkout
$rootPath = Get-NewResource root_path
$linkDir = Get-NewResource link_dir

#check inputs.
$Error.Clear()
if (($svnPath -eq $NULL) -or ($svnPath -eq ""))
{
	Write-Error "***Error: provider requires a 'name' parameter to be set! Ex: 'http://example.com/svn/trunk'"
	exit 131
}
if (($rootPath -eq $NULL) -or ($rootPath -eq ""))
{
	Write-Error "***Error: provider requires 'root_path' parameter to be set! Ex: 'c:\\inetpub'"
	exit 132
}
if (($linkDir -eq $NULL) -or ($linkDir -eq ""))
{
	Write-Error "***Error: provider requires 'link_dir' parameter to be set! Ex: 'wwwroot'"
	exit 133
}

if ($svnUsername -eq $NULL)
{
	$svnUsername=""
}
if ($svnPassword -eq $NULL)
{
	$svnPassword=""
}

#tell the script to "stop" or "continue" when a command fails
$ErrorActionPreference = "stop"

$releasesPath = Join-Path $releasesPath ""

if (!(Test-Path $rootPath)) {
	Write-Output "*** Directory [$rootPath] missing, trying to create."
	mkdir $rootPath
}

if (!(Test-Path $releasesPath)) {
	Write-Output "*** Creating directory: $releasesPath"
	mkdir $releasesPath  > $null
}

$deploy_date = $(get-date -uformat "%Y%m%d%H%M%S")
$deploy_path = Join-Path $releasesPath $deploy_date

$releases=Get-ChildItem $releasesPath | Sort-Object Name -descending | Select-Object Name
if ((($releases.count -eq $null) -and ($releases -eq $null)) -or ($forceCheckout -eq "true"))
{
	Write-Output "*** Creating new releases directory [$deploy_path]"
	mkdir $deploy_path  > $null
	Write-Output "*** SVN checkout in [$deploy_path]"
}
else
{
	if ($releases.count -eq $null)
		{ $latest_release = Join-Path $releasesPath $releases.Name }
	else
		{ $latest_release = Join-Path $releasesPath $releases[0].Name }
	Write-Output "*** Creating new releases directory [$deploy_path]"
	Write-Output "*** Robocopy from [$latest_release] to [$deploy_path]"
   
	$robo_output = invoke-expression 'robocopy.exe $latest_release $deploy_path /PURGE /S /COPYALL /B /E /NP /NFL /NDL'
	Write-Output $robo_output
	if ($robo_output -match "Ended :") 
	{
		Write-Output "*** SVN update in [$deploy_path]"
	}
	else
	{
		Write-Warning "*** Robocopy failed, proceeding with a full checkout in [$deploy_path]"
		if (Test-Path $deploy_path)
		{
			Write-Output "*** Deleting directory [$deploy_path]"
			Remove-Item $deploy_path -r -force
		}
		Write-Output "*** Creating new releases directory [$deploy_path]"
		New-Item $deploy_path -type directory 
	} 
}

svn.cmd --non-interactive --no-auth-cache --username `"$svnUsername`" --password `"$svnPassword`" checkout $svnPath $deploy_path


#if ($?)
#{
#	cmd /c "rmdir $link_path /S /Q & mklink /D $link_path $deploy_path"
#}
#else
#{
#	Write-Error "*** svn checkout failed. Aborting..."
#	exit 121
#}