#
# Cookbook Name:: lb_haproxy
# Recipe:: do_detach_request
#
# Copyright 2009, RightScale, Inc.
#
# All rights reserved - Do Not Redistribute
#
remote_recipe "Detach me from load ballancer" do
  recipe "lb_haproxy::do_detach"
  attributes :remote_recipe => {
                :backend_ip => "10.48.11.63",
                :backend_id => @node[:rightscale][:instance_uuid]
              }
  recipients_tags "loadbalancer:lb=#{@node[:lb_haproxy][:applistener_name]}"
end