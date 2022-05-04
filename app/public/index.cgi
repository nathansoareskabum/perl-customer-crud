#!/usr/bin/perl
use v5.10.1;
use CGI;
use JSON;
use Data::Dumper;
use Cwd;

BEGIN { 
    our %ROUTES = (
        'POST' => {
            '/auth/login' => {
                'module'=> 'Routes::Auth',
                'method' => 'login'
            },
            '/customers' => {
                'module'=> 'Routes::Customers',
                'method' => 'store'
            }
        },
        'GET' => {
            '/customers' => {
                'module'=> 'Routes::Customers',
                'method' => 'list'
            }
        }
    );

    push @INC, '/app/src';
}

use Utils::Response;

my $cgi = CGI->new();
my $json = JSON->new();
my $response = Utils::Response->new(cgi => $cgi, json => $json);

eval {
    my $path = (split('\?', $cgi->request_uri()))[0];
    
    if (defined $ROUTES{$cgi->request_method()}{$path}) {
        
        my $module = $ROUTES{$cgi->request_method()}{$path}{'module'};
        my $method = $ROUTES{$cgi->request_method()}{$path}{'method'};
        
        (my $file = $module) =~ s|::|/|g;
        require '../src/' . $file . '.pm';
        
        $controller = $module->new(response => $response);
        
        $controller->$method();
    }
    
    $response->to_json(404, {
        code => 404,
        message => 'Page not found'
    });
} or do {
    my $error = $@ || 'Internal server error';

    $response->to_json(500, {
        code => 500,
        message => $error
    });
};

__END__