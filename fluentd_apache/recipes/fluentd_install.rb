package "td-agent" do
	action :install
end

cookbook_file "/etc/td-agent/td-agent.conf" do
	source "td-agent.conf"
	action :create
end

service "td-agent" do
        supports :status => true, :restart => true, :reload => true
        action [ :enable, :start ]
end
