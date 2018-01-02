name             'tomcat'
maintainer       'Srilakshmi Attuluri'
maintainer_email 'srilakshmi.attuluri@cognizant.com'
license          'Apache 2.0'
description      'Installs/Configures Tomcat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.5'

supports "redhat"
supports "centos"
supports "amazon"
supports "fedora"

depends "java"
