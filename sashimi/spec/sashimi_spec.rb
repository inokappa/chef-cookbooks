require 'chefspec'

describe 'sashimi::sashimi' do
	let (:chef_run) { ChefSpec::ChefRunner.new.converge 'sashimi::sashimi' }
	it 'stub out data_bag_item' do
		Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
	end
	it 'should created /tmp/menu' do
		expect (chef_run).to create_file '/tmp/menu'
		file = chef_run.template ('')
		expect (file).to be_owned_by ('','')
	end
end
