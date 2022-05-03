package Routes::Auth;

sub new {
    my ($class, %args) = @_;
    
    my $self = \%args;

    bless $self, $class;

    return $self;

}

sub login {
    my $self = shift;

    $self->{response}->json(301, "Login");
}

1;

__END__