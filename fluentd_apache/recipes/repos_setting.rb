cookbook_file "/etc/yum.repos.d/td.repo" do
	source "td.repo"
	mode 00644
end
