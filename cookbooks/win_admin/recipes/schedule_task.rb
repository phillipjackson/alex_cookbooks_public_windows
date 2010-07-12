# Cookbook Name:: win_admin
# Recipe:: schedule_task
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

#if (@node[:database][:backup][:hourly_frequency].nil?)
#  @node[:database][:backup][:hourly_frequency]=""
#end
#
#if (@node[:database][:backup][:daily_time].nil?)
#  @node[:database][:backup][:daily_time]=""
#end

`mkdir c:\\tmp` if !File.directory?('c:\\tmp')

# schedule the task
win_admin_powershell_schtasksprovider "rs_scheduled_task" do
  username "administrator"
  password @node[:win_admin][:admin_password]
  hourly_frequency @node[:schtasks][:hourly_frequency]
  daily_time @node[:schtasks][:daily_time]
  command @node[:schtasks][:command]
  action :add
end






