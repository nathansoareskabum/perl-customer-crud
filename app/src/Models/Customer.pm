package Models::Customer;

use Library::DB;

sub fetch_all {
    my $db = Library::DB->get_instance();

    my $result = $db->query("SELECT * FROM `customers`;");

    my $output = $result->fetchall_arrayref({});

    $result->finish();

    return $output;
}

sub create {
    my ($self, $name, $birth_date, $cpf, $rg, $phone) = (@_);

    my $db = Library::DB->get_instance();

    my $result = $db->query("INSERT INTO `customers` (`name`, `birth_date`, `cpf`, `rg`, `phone`) VALUES (?, ?, ?, ?, ?);");
}

1;

__END__