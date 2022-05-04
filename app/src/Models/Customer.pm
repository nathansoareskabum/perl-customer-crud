package Models::Customer;

use Library::DB;

sub fetch_all {
    my $db = Library::DB->get_instance();

    my $res = $db->query("SELECT * FROM `customers`;");

    my @output = ();

    my ($id, $name, $birth_date, $cpf, $rg, $phone);

    while(($id, $name, $birth_date, $cpf, $rg, $phone) = $res->fetchrow()){
        push @output, {
            id => $id,
            name => $name,
            birth_date => $birth_date,
            cpf => $cpf,
            rg => $rg,
            phone => $phone
        };
    }

    $res->finish();

    return @output;
}

1;

__END__