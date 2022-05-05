package Controllers::CustomersController;

use Models::Customer;

use Moose;

has 'response' => (
    is => 'rw', 
    required => 1
);

sub list {
    my $self = shift;

    my $output = Models::Customer::fetch_all();

    $self->response->to_json(301, $output);
}

sub store {
    
    # $self->response->to_json(301, \@output);
}

sub test {
    my $self = shift;

    $self->response->to_json(301, {
        'test' => 'ok',
        'backoffice' => '00'
    });
}

1;

__END__