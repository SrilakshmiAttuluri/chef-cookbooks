#default[:tomcat][:https_port] = 8443
default[:tomcat][:home] = '/opt/tomcat_helloworld/'
default[:tomcat][:app_name] = 'spring-petclinic'
default[:tomcat][:app_version] = '1.0-SNAPSHOT'
default[:tomcat][:nexus_url] = 'http://34.196.120.121:8081/nexus/service/local/artifact/maven/redirect?r=snapshots&g=org.springframework.samples&a=spring-petclinic&v=1.0-SNAPSHOT&p=war'
#nexus_url: http://34.196.120.121:8081/nexus/content/repositories/snapshots
