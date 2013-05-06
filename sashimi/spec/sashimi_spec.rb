require 'chefspec'

describe 'sashimi::sashimi' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'sashimi::sashimi' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
