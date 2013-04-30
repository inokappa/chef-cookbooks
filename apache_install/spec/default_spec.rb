require 'chefspec'

describe 'apache_install::default' do
	let (:chef_run) { ChefSpec::ChefRunner.new.converge 'apache_install::default' }
	#
#	%w{httpd}.each do |package_name|
		#it 'installs #{package_name}' do
		it 'install httpd' do
			#chef_run.should install_package package_name
			expect(chef_run).to install_package 'httpd'
		end
#	end
	#
	it 'start httpd on boot' do
		expect(chef_run).to set_service_to_start_on_boot 'httpd'
	end

	describe 'change port' do
		it 'create port.conf' do
			expect(chef_run).to create_cookbook_file '/etc/httpd/conf.d/port.conf'
			file = chef_run.cookbook_file('/etc/httpd/conf.d/port.conf')
			expect(file).to be_owned_by('root','root')
			expect(file.mode).to eq "00644"
			expect(file).to notify('service[httpd]',:reload)
		end		
	end
	#
	describe 'set contents' do
		it 'setting test.html' do
			chef_run.should create_cookbook_file '/var/www/html/test.html'
			file = chef_run.cookbook_file('/var/www/html/test.html')
			expect(file).to be_owned_by('root','root')
			expect(file.mode).to eq "00644"
		end
	end

end
