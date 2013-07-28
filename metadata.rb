name             'wp-shell'
maintainer       'Michael Lanyon'
maintainer_email 'lanyonm@gmail.com'
license          'Apache 2.0'
description      'Provides a recipe for configuring a shell for a Wordpress installation.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe           'wp-shell', 'Installs the VirtualHost and wp-config.php file required to run a Wordpress site.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apache2 apt build-essential git mysql php rsync vim }.each do |cb|
  depends cb
end
