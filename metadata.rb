name             'cens-base'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures cens-base'
long_description 'Installs/Configures cens-base'
version          '0.1.1'

depends "system", "~> 0.3.3"
depends "vim", "~> 1.1.2"
depends "emacs", "~> 0.9.0"
depends "ntp", "~> 1.6.5"
depends 'openssh', '~> 1.3.4'
depends 'nfs', '~> 2.0.0'
depends 'curl', '~> 2.0.1'
depends 'apt'