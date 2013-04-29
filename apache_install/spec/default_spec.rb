require 'chefspec'

describe 'apache_install::default' do
	let (:chef_run) { ChefSpec::ChefRunner.new.converge 'apache_install::default' }
	#
	%w{httpd}.each do |package_name|
		it 'installs #{package_name}' do
			chef_run.should install_package package_name
		end
	end
	#
	it 'start httpd on boot' do
		chef_run.should set_service_to_start_on_boot 'httpd'
	end

	describe 'change port' do
		it 'create port.conf' do
			chef_run.should create_cookbook_file '/etc/httpd/conf.d/port.conf'
			file = chef_run.cookbook_file('/etc/httpd/conf.d/port.conf')
			expect(file).should be_owned_by('root','root')
			expect(file.mode).should eq "00644"
			expect(file).should notify('service[httpd]',:reload)
		end		
	end
end
