package BabyryAPI::Service::Sequence;

use strict;
use warnings;
use parent qw/BabyryAPI::Service::Base/;

sub issue {
    my ($self, $type) = @_;

    warn "service";
    my $teng = $self->teng('BABYRY_MAIN_W');

    $teng->txn_begin;
    my $id = $self->model('sequence')->issue($teng, $type);
    $teng->txn_commit;

    return { id => $id };
}

1;

