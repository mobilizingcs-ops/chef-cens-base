name             'cens-base'
maintainer       'steve nolen'
maintainer_email 'technolengy@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures cens-base'
long_description 'Installs/Configures cens-base'
version          '0.2.1'

depends "system", "~> 0.3.3"
depends "vim", "~> 1.1.2"
depends "emacs", "~> 0.9.0"
depends "ntp", "~> 1.6.5"
depends 'openssh', '~> 1.3.4'
depends 'nfs', '~> 2.0.2'
depends 'curl', '~> 2.0.1'
depends 'postfix', '~> 3.6.2'
depends 'apt', '~> 2.6.1'
depends 'chef-client', "~> 4.0.0"