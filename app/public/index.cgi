#!/usr/bin/perl
use v5.10.1;
use CGI;
use JSON;

BEGIN { 
    our %ROUTES = (
        'POST' => {
            '/auth/login' => {
                'module'=> 'Controllers::AuthController',
                'method' => 'login'
            },
            '/customers' => {
                'module'=> 'Controllers::CustomersController',
                'method' => 'store'
            }
        },
        'GET' => {
            '/customers' => {
                'module'=> 'Controllers::CustomersController',
                'method' => 'list'
            },
            '/customers/:id' => {
                'module'=> 'Controllers::CustomersController',
                'method' => 'test'
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
        
        my $route = $ROUTES{$cgi->request_method()}{$path};

        my $module = $route->{'module'};
        my $method = $route->{'method'};
        
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