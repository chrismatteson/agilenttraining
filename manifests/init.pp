class windowstraininglab (
  $students = hiera_hash('windowstraininglab::students_hash')
  ){

  contain windowstraininglab::nodes

}
