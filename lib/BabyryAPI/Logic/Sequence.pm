package BabyryAPI::Logic::Sequence;
use strict;
use warnings;
use utf8;

use parent qw/BabyryAPI::Logic::Base/;
use BabyryAPI::Service::Sequence;

sub issue {
    my ($self, $type) = @_;

    warn "logic";
    return BabyryAPI::Service::Sequence->new->issue($type);
}

1;

