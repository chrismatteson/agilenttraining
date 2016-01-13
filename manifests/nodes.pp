class windowstraininglab::nodes (
  $students = hiera_hash(windowstraininglab::students_hash, $windowstraininglab::params::students),
) inherits windowstraininglab::params {

  $public_key = split($ec2_public_keys_0_openssh_key, ' ')
  $awskey = $public_key[2]

  $studentappserver = keys($students)
  $studentinstcontroller = keys($students)
  $studentclient = keys($students)

  windowstraininglab::ec2instance { ['training-dc-01','training-dc-02','training-rd-01']:
    image_id           => $windowstraininglab::params::windows2012,
    pp_created_by      => $ec2_tags['created_by'],
    key_name           => $awskey,
    pe_master_hostname => $::ec2_local_hostname,
  }

  define appserver_array( $awskey ) {
    windowstraininglab::ec2instance { "$title-app-server":
      nodename           => "$title-app-server",
      image_id           => $windowstraininglab::params::windows7,
      pp_created_by      => $ec2_tags['created_by'],
      key_name           => $awskey,
      pe_master_hostname => $::ec2_local_hostname,
    }
  }
  appserver_array{$studentappserver: 
    awskey => $awskey,
  }

  define inst_controller_array( $awskey ) {
    windowstraininglab::ec2instance { "$title-inst-controller":
      nodename           => "$title-inst-controller",
      image_id           => $windowstraininglab::params::windows7,
      pp_created_by      => $ec2_tags['created_by'],
      key_name           => $awskey,
      pe_master_hostname => $::ec2_local_hostname,
    }
  }
  inst_controller_array{$studentinstcontroller:
    awskey => $awskey,
  }

  define client_array( $awskey ) {
    windowstraininglab::ec2instance { "$title-client":
      nodename           => "$title-client",
      image_id           => $windowstraininglab::params::windows7,
      pp_created_by      => $ec2_tags['created_by'],
      key_name           => $awskey,
      pe_master_hostname => $::ec2_local_hostname,
    }
  }
  client_array{$studentclient:
    awskey => $awskey,
  }

  @@host { $fqdn:
    ensure       => 'present',
    host_aliases => $hostname,
    ip           => $ipaddress,
  }

  Host <<| |>>

}
