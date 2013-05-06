#
sashimis = data_bag_item('fishies','sashimi')['menu']
template  '/tmp/menu' do
        owner "root"
        group "root"
        source "menu.erb"
        variables(
                :sashimis =>  sashimis
        )
end
