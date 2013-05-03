#
# Cookbook Name:: apache_install
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "httpd" do
	action :install
end

service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start]
	#subscribes :reload, resources("cookbook_file[/etc/httpd/conf.d/port.conf]"), :immediately
end

cookbook_file "/etc/httpd/conf.d/port.conf" do
	source "port.conf"
	mode "00644"
	owner "root"
	group "root"
	#action :create
	notifies :reload, resources(:service => "httpd")
end
#
cookbook_file "/var/www/html/test.html" do
	source "test.html"
	mode "00644"
	owner "root"
	group "root"
	action :create
end

hosts = databag('etc_hosts')
template  '/tmp/hosts' do
	owner "root"
	group "root"
	source "hosts"
	variables(
		hosts: hosts
	)
end
