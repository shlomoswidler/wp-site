# installs wordpress

include_recipe 'wordpress'
package "php5-curl" # W3TC needs this
include_recipe "apache2::mod_expires"
include_recipe 'chef-newrelic-sysmond'

