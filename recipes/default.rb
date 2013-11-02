# installs wordpress

include_recipe 'wordpress'
package "php5-curl" # W3TC needs this
include_recipe 'chef-newrelic-sysmond'

