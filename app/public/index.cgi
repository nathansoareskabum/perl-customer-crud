#!/usr/bin/perl
use v5.10.1;
use CGI;
use JSON;
use Data::Dumper;
use Cwd;

BEGIN { 
    our %ROUTES = (
        'GET' => {
            '/auth/login' => {
                'module'=> 'Routes::Auth',
                'method' => 'login'
            }
        }
    );

    push @INC, '/app';
}

use Utils::Response;

our $cgi = CGI->new();
our $json = JSON->new();
our $response = Utils::Response->new(cgi => $cgi, json => $json);

eval {
    my $output = {
        code => 404,
        message => 'Page not found'
    };

    my $path = (split('\?', $cgi->request_uri()))[0];
    
    if (defined $ROUTES{$cgi->request_method()}{$path}) {
        
        my $module = $ROUTES{$cgi->request_method()}{$path}{'module'};
        my $method = $ROUTES{$cgi->request_method()}{$path}{'method'};
        
        (my $file = $module) =~ s|::|/|g;
        require '../' . $file . '.pm';
        
        $controller = $module->new(response => $response);
        
        $controller->$method();
    }
    
    $response->json($output->{code}, $output->{message});
} or do {
    my $error = $@ || 'Unknown failure';

    $response->json(500, $error);
};

__END__