class windowstraininglab::nodes::client {

  include windowstraininglab::nodes::joindomain

  $studentarray = split($clientcert, '-')
  $student = $studentarray[0]

  group { 'Administrators':
    members => ["traininglab.local\\$student",'traininglab.local\Domain Admins','Administrator'],
  }

}
