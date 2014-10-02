#turn off services
%w{'apparmor', 'whoopsie'}.each do |svc|
  service svc do
    action [:stop,:disable]
    ignore_failure true
  end
end

#turn off byobu
file "/etc/profile.d/Z98-byobu" do
  action :delete
  not_if do
    node.recipe?("byobu")
  end
end

%w{popularity-contest unity-lens-shopping whoopsie}.each do |pkg|
  package pkg do
    action :purge
    ignore_failure true
  end
end

execute "apt-get update" do
  action :nothing
end.run_action(:run)

include_recipe "mysql::client"

pkg = value_for_platform(
    %w(centos redhat scientific fedora amazon) => {
      "default" => "php53-mysql"
    },
    "default" => "php5-mysql"
  )

package pkg do
  action :install
end

include_recipe "apache2::default"

apache_site '000-default' do
  enable false
end

include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_ssl"
package 'php5-gd'
package 'php5-imagick'
package 'zip'
package 'postfix'

# W3TC needs these
package "php5-curl" 
package 'php5-memcache'
package 'php5-tidy'
package 'php-apc'
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"

include_recipe 'shlomo-newrelic'
include_recipe 'shlomo-newrelic::php'
include_recipe 'shlomo-newrelic::meetme-plugin'
include_recipe 'shlomo-newrelic::aws'

package 'php5-fpm' do
  action :purge
  ignore_failure true
end
