class windowstraininglab::nodes::rdgateway {

  include windowstraininglab::nodes::domainnode

  windowsfeature { ['RDS-Gateway','RDS-Web-Access','RSAT-RDS-Tools','RSAT-RDS-Gateway']:
    ensure => 'present',
  }

  file { 'c:\tsgateway.xml':
    source => 'puppet:///modules/windowstraininglab/tsgateway.xml',
    ensure => 'file',
  }

}
