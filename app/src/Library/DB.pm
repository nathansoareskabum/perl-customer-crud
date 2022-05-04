package Library::DB;

use Moose;
use DBI;

has 'database' => (
    is => 'ro', 
    required => 1
);

has 'hostname' => (
    is => 'ro', 
    required => 1
);

has 'port' => (
    is => 'ro', 
    required => 1
);

has 'user' => (
    is => 'ro', 
    required => 1
);

has 'pass' => (
    is => 'ro', 
    required => 1
);

my $instance = undef;

sub get_instance {

    unless ($instance) {
        $instance = shift->new(
            database => 'test',
            hostname => 'mysql',
            port => 3306,
            user => 'root',
            pass => 'secret'
        );
    }

    return $instance;
}

sub query {
    my $self = shift;
    my $query = shift;

    my $database = $self->database;
    my $hostname = $self->hostname;
    my $port = $self->port;

    my $connection = DBI->connect(
        "DBI:mysql:database=$database;host=$hostname;port=$port", 
        $self->user, 
        $self->pass
    ) or die "Can't connect to database: $DBI::errstr\n";

    my $statement = $connection->prepare($query);

    $statement->execute();

    return $statement;
}

1;
