class java {
    include apt
    
    apt::ppa { 'ppa:webupd8team/java': }
    
    ensure_packages(['oracle-java7-installer'])
    
    exec { 'accept-java-license':
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      command => 'echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
      before  => Package['oracle-java7-installer'],
      unless  => 'which java',
    }
    
    exec { 'update-java-alternatives':
      path        => '/usr/bin:/usr/sbin:/bin:/sbin',
      command     => "update-java-alternatives --set java-7-oracle",
      refreshonly => true,
      subscribe   => Package['oracle-java7-installer'],
    }
}
