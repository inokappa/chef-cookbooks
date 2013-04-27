package "httpd" do
	action :install
end

directory "/var/log/httpd" do
	mode "00755"
end

service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

