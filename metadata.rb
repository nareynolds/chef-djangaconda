name             'djangaconda'
maintainer       'nareynolds'
maintainer_email 'nathaniel.reynolds@gmail.com'
license          'All rights reserved'
description      'Installs/Configures djangaconda'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

depends          'anaconda', '~> 0.5.2'
depends          'git', '~> 4.2.2'
depends          'postgresql', '~> 3.4.20'
depends          'database', '~> 4.0.6'
