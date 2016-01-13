class agilenttraining::nodes::dc2 (
) inherits agilenttraining::params {

  include agilenttraining::nodes::domainnode

  @@agilenttraining::dnsclient { $fqdn:
    nameservers => $ipaddress,
  }
 
}
