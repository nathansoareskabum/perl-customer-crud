package Utils::Response;

use Moose;

has 'cgi' => (
    is => 'rw', 
    required => 1
);

has 'json' => (
    is => 'rw', 
    required => 1
);

sub to_json {
    my $self = shift;

    my($code, $message) = @_;

    print $self->cgi->header(
        -type => 'application/json',
        -status => $code
    );

    print $self->json->encode({
        code => $code,
        message => $message
    }); 

    exit;
}

1;

__END__