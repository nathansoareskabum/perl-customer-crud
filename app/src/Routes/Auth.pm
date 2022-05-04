package Routes::Auth;

use Moose;

has 'response' => (
    is => 'rw', 
    required => 1
);

sub login {
    my $self = shift;

    $self->response->to_json(200, {
        message => "Login Route"
    });
}

1;

__END__