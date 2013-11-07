# installs wordpress

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

include_recipe 'shlomo-wordpress'

# W3TC needs these
package "php5-curl" 
package 'php5-memcache'
package 'php5-tidy'
package 'php-apc'
include_recipe "apache2::mod_expires"

include_recipe 'shlomo-newrelic'
include_recipe 'shlomo-newrelic::php'

