package BabyryAPI::Web::C::Sequence;

use strict;
use warnings;

use parent qw/BabyryAPI::Web::C/;
use BabyryAPI::Logic::Sequence;

sub issue {
    my ($self, $c, $p, $v) = @_;

    my $type = $c->req->param('type');
    warn "controller type:$type";

    my $ret = eval {
        BabyryAPI::Logic::Sequence->new->issue($type);
    } || {};
    return $self->output_response_json($c, $ret, $@);
}

1;

