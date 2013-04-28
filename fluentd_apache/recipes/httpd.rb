cookbook_file "/etc/httpd/conf.d/common.conf" do
	source "common.conf"
	mode 0644
	action :nothing
end

package "httpd" do
	action :install
	notifies :create, resources( :template => "/etc/httpd/conf.d/common.conf" )
end
