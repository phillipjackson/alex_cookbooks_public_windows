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
$zipPath = Get-NewResource zip_path
$releasesPath = Get-NewResource releases_path

#check inputs.
$Error.Clear()
if (($zipPath -eq $NULL) -or ($zipPath -eq ""))
{
	Write-Error "Error: provider requires 'zip_path' parameter to be set! Ex: 'c:\\tmp\\app.zip'"
	exit 141
}
if (($releasesPath -eq $NULL) -or ($releasesPath -eq ""))
{
	Write-Error "Error: provider requires 'root_path' parameter to be set! Ex: 'c:\\inetpub'"
	exit 142
}

#tell the script to "stop" or "continue" when a command fails
$ErrorActionPreference = "stop"

$releasesPath = Join-Path $releasesPath ""

if (!(Test-Path $releasesPath)) {
	Write-Output "Creating directory: $releasesPath"
	New-Item $releasesPath -type directory 
}

$deploy_date = $(get-date -uformat "%Y%m%d%H%M%S")
$deploy_path = Join-Path $releasesPath $deploy_date

if (!(test-path $zipPath))
{
	Write-Error "Error: [$zipPath] does not exist. Aborting!"
	exit 143 
}

Write-Output "Unpacking [$zipPath] to [$deploy_path]"

cmd /c 7z x -y "$zipPath" -o$deploy_path

if ($LastExitCode -ne 0)
{ 
	Write-Error "Error: Unzipping failed"
	exit 144
}
else
{
	Set-ChefNode releasesunzippath $deploy_path
}