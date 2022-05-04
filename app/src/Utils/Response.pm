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

    my($code, $obj) = @_;

    print $self->cgi->header(
        -type => 'application/json',
        -status => $code
    );

    print $self->json->encode($obj); 

    exit;
}

1;

__END__