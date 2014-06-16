package BabyryAPI::Common;

use strict;
use warnings;

use parent qw/BabyryAPI/;
use Log::Minimal;
use BabyryAPI;
use BabyryAPI::ConfigLoader;


our $__KEYVAULT;

sub env {
    return 'local' if !$ENV{APP_ENV};
    return $ENV{APP_ENV} eq 'production'  ?  'production'  :
           $ENV{APP_ENV} eq 'development' ?  'development' :
                                             'local'       ;
}

sub config { BabyryAPI::ConfigLoader->new(env())->config }


sub get_key_vault {
    my ($class, $key) = @_;

    _load_keyvault() unless $__KEYVAULT;
    return exists $__KEYVAULT->{$key}
        ? $__KEYVAULT->{$key}
        : croakf("get_key_vault failed. key: $key");
}

sub _load_keyvault {
    my $config_full_path = sprintf('%s',
        BabyryAPI::Common->config->{key_vault_config}
    );
    croakf( sprintf('keyvault config file not found. path: %s', $config_full_path))
        unless -f $config_full_path;

    $__KEYVAULT = do( $config_full_path );
}

sub db_config { BabyryAPI::ConfigLoader->new(env())->db_config }

1;

