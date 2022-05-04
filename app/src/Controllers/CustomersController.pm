package Controllers::CustomersController;

use Models::Customer;

use Moose;

has 'response' => (
    is => 'rw', 
    required => 1
);

sub list {
    my $self = shift;

    my @output = Models::Customer::fetch_all();

    $self->response->to_json(301, \@output);
}

1;

__END__