default['ghalib']['user'] = 'vagrant'
default['ghalib']['app_root'] = '/vagrant'
default['ghalib']['home'] = '/home/' + default['ghalib']['user']

default['rbenv']['user_installs'] = [{'user' => 'vagrant',
                                       'rubies' => ['2.1.1'],
                                       'global' => '2.1.1'}]
default['rbenv']['gems'] = {'2.1.1' => [{'name' => 'bundler'}]}
