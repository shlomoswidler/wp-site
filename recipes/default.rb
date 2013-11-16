# installs wordpress

include_recipe 'wp-site::prepare_environment'

include_recipe 'wp-site::deploy_wordpress'
