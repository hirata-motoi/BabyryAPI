package BabyryAPI::Web::ViewFunctions;
use strict;
use warnings;
use utf8;
use parent qw(Exporter);
use Module::Functions;
use File::Spec;
use JSON;

our @EXPORT = get_public_functions();

sub commify {
    local $_  = shift;
    1 while s/((?:\A|[^.0-9])[-+]?\d+)(\d{3})/$1,$2/s;
    return $_;
}

sub c { BabyryAPI->context() }
sub uri_with { BabyryAPI->context()->req->uri_with(@_) }
sub uri_for { sprintf('%s?%d', BabyryAPI->context()->uri_for(@_), time) }

{
    my %static_file_cache;
    sub static_file {
        my $fname = shift;
        my $c = BabyryAPI->context;
        if (not exists $static_file_cache{$fname}) {
            my $fullpath = File::Spec->catfile($c->base_dir(), $fname);
            $static_file_cache{$fname} = (stat $fullpath)[9];
        }
        return $c->uri_for(
            $fname, {
                't' => $static_file_cache{$fname} || 0
            }
        );
    }
}


sub encode_json_kolon {
    my ( $text ) = @_;
    return "[]" if ( !$text );
    return JSON->new->utf8(0)->encode($text)
}

1;
