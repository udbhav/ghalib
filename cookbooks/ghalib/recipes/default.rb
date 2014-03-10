include_recipe "apt"
include_recipe "nginx"
include_recipe "python"
include_recipe "postgresql::server"
include_recipe "nodejs::install_from_package"
include_recipe "supervisor"
include_recipe "ruby_build"
include_recipe "rbenv::user"

# pillow requirements
%w(libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev).each do |pkg|
  package pkg do
    action :install
  end
end

# rbenv and bundler
execute "rbenv-bundler" do
  path = node['ghalib']['home'] + '/.rbenv/plugins/bundler'
  git_url = "git://github.com/carsomyr/rbenv-bundler.git"
  # if dir doesn't exist
  command "[ -d #{path} ] || git clone #{git_url} #{path}"
  user "vagrant"
end
