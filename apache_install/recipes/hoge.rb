#
service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action :nothing
end
#
template "/tmp/hoge" do
	source "hoge.erb"
	mode "0644"
	owner "root"
	group "root"
	action :create
	variables(
		:hoge => node["hoge"]
	)
	notifies :reload, "service[httpd]", :immediately
end
