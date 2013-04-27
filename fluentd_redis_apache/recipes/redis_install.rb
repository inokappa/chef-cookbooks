redis_tar="redis-2.6.12.tar.gz"
redis_src="redis-2.6.12"
remote_file /usr/local/src/#redis_tar do
        source http://redis.googlecode.com/files/#redis_tar
        notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
        not_if "ls /usr/local/bin/redis-server"
        user "root"
        cwd "/usr/local/src"
        code <<-EOH
                tar -zxf #redis_tar
                (cd #redis_src/ && make test && make && make install)
        EOH
end

bash "starting_redis" do
        not_if "ps aux | grep redis-server |grep -v"
        user "root"
        code <<-EOH
                /usr/local/bin/redis-server &
        EOH
        #action :nothing
end
