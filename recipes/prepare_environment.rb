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
end

repo=`grep 'deb http.*precise main' /etc/apt/sources.list | cut -d' ' -f 2`
["precise multiverse", "precise-updates multiverse"].each do |expr|
  execute "add #{expr} deb repository" do
    user 'root'
    group 'root'
    command <<-EOF
      echo 'deb #{repo} #{expr}' >> /etc/apt/sources.list.d/multiverse.list
    EOF
    not_if do
      find = Mixlib::ShellOut.new("find /etc/apt/ -name '*.list' | xargs cat | grep  ^[[:space:]]*deb[[:space:]].*#{expr}").run_command
      find.exitstatus && find.stdout.length>1
    end
    action :nothing
    notifies :run, "execute[apt-get update]", :immediately
  end.run_action(:run)
end

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
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_ssl"

# W3TC needs these
package "php5-curl" 
package 'php5-memcache'
package 'php5-tidy'
package 'php-apc'
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_"
include_recipe "apache2::mod_php5_apache"

package 'php5-fpm'
package 'libapache2-mod-fastcgi'

include_recipe 'shlomo-newrelic'
include_recipe 'shlomo-newrelic::php'

