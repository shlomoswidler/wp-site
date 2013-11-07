# installs wordpress

include_recipe 'annoyances-cookbook::ubuntu'
include_recipe 'shlomo-wordpress'
package "php5-curl" # W3TC needs this
package 'php5-memcached'
package 'php5-tidy'
package 'php-apc'
include_recipe "apache2::mod_expires"
include_recipe 'shlomo-newrelic'
include_recipe 'shlomo-newrelic::php'

