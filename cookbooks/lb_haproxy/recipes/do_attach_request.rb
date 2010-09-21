#
# Cookbook Name:: lb_haproxy
# Recipe:: do_attach_request
#
# Copyright 2009, RightScale, Inc.
#
# All rights reserved - Do Not Redistribute
#

right_link_tag "loadbalancer:app=#{@node[:lb_haproxy][:applistener_name]}"
Chef::Log.info("*** App listener is: #{@node[:lb_haproxy][:applistener_name]}")
#Chef::Log.info("*** Private ip is: #{@node[:network][:interfaces][:configuration][:ip_address]}")

remote_recipe "Attach me to load ballancer" do
  recipe "lb_haproxy::do_attach"
  attributes :remote_recipe => {
                :backend_ip => "10.48.11.63",
                :backend_id => @node[:rightscale][:instance_uuid]
              }
              
  recipients_tags "loadbalancer:lb=#{@node[:lb_haproxy][:applistener_name]}"
end


