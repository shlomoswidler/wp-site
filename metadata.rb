name             'wp-site'
maintainer       'Shlomo Swidler'
maintainer_email 'shlomo.swidler@orchestratus.com'
license          'All rights reserved'
description      'Installs/Configures wp-site'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

recipe 'default', "Install/Configure wp-site"

supports "ubuntu"

depends 'shlomo-wordpress', "= 0.1.0"
depends 'shlomo-newrelic', "= 0.2.0"
depends 'apache2', '>= 1.0'
depends 'newrelic_plugins', '>= 1.0.1'
