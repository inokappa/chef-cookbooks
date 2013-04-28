install_ruby_version="1.9.3-p392"
#
git "/usr/local/rbenv" do
	repository "git://github.com/sstephenson/rbenv.git"
	reference "master"
	action :sync
	not_if "ls /usr/local/rbenv"
end

execute "source_profile" do
	cwd "/etc"
	command <<-EOH
		echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile
		echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile
		echo 'eval "$(rbenv init -)"' >> /etc/profile
		source /etc/profile
	EOH
	not_if "grep rbenv /etc/profile"
end

directory "/usr/local/rbenv/plugins" do
	mode "00755"
	action :create
	not_if "ls /usr/local/rbenv/plugins"
	#action :nothing
end

git "/usr/local/rbenv/plugins/ruby-build" do
	repository "git://github.com/sstephenson/ruby-build.git"
	reference "master"
	action :sync
	#notifies :create,resources( :directory => "/usr/local/rbenv/plugins" )
end

bash "install_ruby_build" do
	cwd "/usr/local/rbenv/plugins/ruby-build"
	user "root"
	group "root"
	code <<-EOH
		./install.sh
	EOH
	environment 'PREFIX' => "/usr/local"
end

bash "ruby_install" do
	cwd "/usr/local/rbenv/bin"
	code <<-EOH
		./rbenv install #install_ruby_version
		./rbenv rehash
		./rbenv global #install_ruby_version
	EOH
	not_if "ls /usr/local/rbenv/shims/ruby"
end
