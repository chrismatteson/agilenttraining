class windowstraininglab::nodes::domainnode {

  class { 'domain_membership':
    domain       => 'traininglab.local',
    username     => 'joindomain',
    password     => 'PuppetLab5!',
    join_options => '3',
  }
  contain domain_membership

  Windowstraininglab::Dnsclient <<| |>> {
    before => Class['domain_membership'],
  }

  @@host { $fqdn:
    ensure       => 'present',
    host_aliases => [$hostname,$clientcert],
    ip           => $ipaddress,
  }

  Host <<| |>> {
    before => Class['domain_membership'],
  }
}
