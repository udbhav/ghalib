include_recipe "apt"
include_recipe "nginx"
include_recipe "python"
include_recipe "postgresql::server"
include_recipe "nodejs::install_from_package"
include_recipe "supervisor"

# pillow requirements
%w(libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev).each do |pkg|
  package pkg do
    action :install
  end
end
