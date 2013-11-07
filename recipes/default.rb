# installs wordpress

include_recipe 'annoyances::ubuntu'
include_recipe 'shlomo-wordpress'
package "php5-curl" # W3TC needs this
include_recipe "apache2::mod_expires"
include_recipe 'shlomo-newrelic'

