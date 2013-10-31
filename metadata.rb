name             'wp-site'
maintainer       'Shlomo Swidler'
maintainer_email 'shlomo.swidler@orchestratus.com'
license          'All rights reserved'
description      'Installs/Configures wp-site'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'default', "Install/Configure wo-site"

depends 'wordpress'
depends 'chef-newrelic-sysmond'
