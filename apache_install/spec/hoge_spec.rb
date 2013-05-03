require 'chefspec'

describe 'apache_install::hoge' do
	let (:chef_run) { ChefSpec::ChefRunner.new.converge 'apache_install::hoge' }
	#it 'should restart httpd' do
	#	expect(chef_run).to restart_service 'httpd'
	#end
	it 'should set /tmp/hoge' do
		expect(chef_run).to create_file '/tmp/hoge'
		file = chef_run.template('/tmp/hoge')
		expect(file.mode).to eq("0644")
		expect(file).to be_owned_by('root','root')
		expect(file).to notify('service[httpd]',:reload)
	end
end
