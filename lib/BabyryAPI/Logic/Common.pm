package BabyryAPI::Logic::Common;


use strict;
use warnings;

use parent qw/BabyryAPI::Logic::Base/;
use Log::Minimal;
use BabyryAPI::Common;
use Digest::SHA qw/hmac_sha256_hex/;

# TODO implement more strictly
sub enc_password {
    my ($self, $password) = @_;
    my $secret = BabyryAPI::Common->get_key_vault('register_secret');
    return hmac_sha256_hex($password . $secret);
}

1;

