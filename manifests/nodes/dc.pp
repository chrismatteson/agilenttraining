class windowstraininglab::nodes::dc (
  $students = hiera_hash('windowstraininglab::students_hash', $windowstraininglab::params::students)
) inherits windowstraininglab::params {

  class {'windows_ad':
    install                => 'present',
    installmanagementtools => true,
    restart                => true,
    installflag            => true,
    configure              => 'present',
    configureflag          => true,
    domain                 => 'forest',
    domainname             => 'traininglab.local',
    netbiosdomainname      => 'traininglab',
    domainlevel            => '6',
    forestlevel            => '6',
    databasepath           => 'c:\\windows\\ntds',
    logpath                => 'c:\\windows\\ntds',
    sysvolpath             => 'c:\\windows\\sysvol',
    installtype            => 'domain',
    dsrmpassword           => 'PuppetLabs!',
    installdns             => 'yes',
    localadminpassword     => 'PuppetLabs!',
  }

  windows_ad::user { 'joindomain':
    accountname  => 'joindomain',
    firstname    => 'join',
    lastname     => 'domain',
    path         => 'CN=Users,DC=TRAININGLAB,DC=LOCAL',
    password     => 'PuppetLab5!',
  }

  windows_ad::groupmembers { 'joindomain':
    ensure    => 'present',
    groupname => 'Domain Admins',
    members   => 'joindomain',
    require   => Windows_ad::User['joindomain'],
  }

  Windows_ad::User {
    path => 'CN=Users,DC=TRAININGLAB,DC=LOCAL',
  }

  create_resources(windows_ad::user, $students)

  windows_ad::group {'students':
    ensure        => 'present',
    displayname   => 'students',
    path          => 'CN=Users,DC=TRAININGLAB,DC=LOCAL',
    groupname     => 'students',
    groupscope    => 'Global',
    groupcategory => 'Security',
  }

  $studentsarray = keys($students)
  $studentslist = join($studentsarray, ',')

  windows_ad::groupmembers { 'students':
    ensure    => 'present',
    groupname => 'students',
    members   => $studentslist,
    require   => Windows_ad::Group['students'],
  }

  @@windowstraininglab::dnsclient { $fqdn:
    nameservers => $ipaddress,
  }
 
  Windowstraininglab::Dnsclient <<| |>>

  @@host { $fqdn:
    ensure       => 'present',
    host_aliases => $hostname,
    ip           => $ipaddress,
  }

  Host <<| |>>

}
