package BabyryAPI::Model::ImageFile::Png;

use strict;
use warnings;
use parent qw/BabyryAPI::Model::ImageFile/;
use BabyryAPI;
use BabyryAPI::Common;

use Log::Minimal;
use Imager;
use Carp;

sub new {
    my ($class, $params) = @_;

    my $img = Imager->new;
    $img->read( file => $params->{path}, type => 'png' )
        or croak($img->errstr);

    my $self = {
        %$params,
        img => $img
    };
    return bless $self, $class;
}

1;

