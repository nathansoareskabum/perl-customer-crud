package Utils::Response;

sub new {
    my ($class, %args) = @_;
    
    my $self = \%args;

    bless $self, $class;

    return $self;

}

sub json {
    my $self = shift;

    my($code, $message) = @_;

    print $self->{cgi}->header(
        -type => 'application/json',
        -status => $code
    );

    print $self->{json}->encode({
        code => $code,
        message => $message
    }); 
    exit;
}

1;

__END__