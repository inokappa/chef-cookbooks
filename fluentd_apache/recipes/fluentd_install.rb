package "td-agent" do
	action :install
end

cookbook_file "/etc/td-agent/td-agent.conf" do
	mode "00644"
	source "td-agent.conf"
	action :create
end

directory "/tmp/td-agent" do
	mode "00777"
endc

service "td-agent" do
        supports :status => true, :restart => true, :reload => true
        action [ :enable, :start ]
end
