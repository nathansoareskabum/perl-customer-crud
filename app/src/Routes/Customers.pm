package Routes::Customers;

use Moose;
use Library::DB;

has 'response' => (
    is => 'rw', 
    required => 1
);

sub list {
    my $self = shift;

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

    $self->response->to_json(301, \@output);
}

1;

__END__