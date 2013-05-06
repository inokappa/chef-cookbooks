require 'chefspec'

describe 'sashimi::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'sashimi::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
