name             'AWS'
maintainer       'Srilakshmi Attuluri'
maintainer_email 'srilakshmi.attuluri@cognizant.com'
license          'Apache 2.0'
description      'Installs python'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

supports "redhat"
supports "centos"
supports "amazon"
supports "fedora"

depends "java"
depends 'poise-python', '~> 1.6.0'
