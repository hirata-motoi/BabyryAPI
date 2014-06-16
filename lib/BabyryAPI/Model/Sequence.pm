package BabyryAPI::Model::Sequence;
use strict;
use warnings;
use utf8;

use parent qw/BabyryAPI::Model::Base/;
use BabyryAPI::Common;

sub issue {
    my ($self, $teng, $type) = @_;

    warn "model";

    my $table = BabyryAPI::Common->config->{seq_table_map}{$type}
        or croak("seq_table not fount type:$type");

    $teng->do("UPDATE $table SET id=LAST_INSERT_ID(id+1)");
    my $row = $teng->dbh->selectall_arrayref("SELECT LAST_INSERT_ID() AS id", +{Slice => {}});
    return $row->[0]->{id};
}

1;

