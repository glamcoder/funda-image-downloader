#!/usr/bin/perl
use strict;
use warnings;

use LWP::Simple;
use WWW::Mechanize;

my $url = $ARGV[0];
my $output_dir = $ARGV[1];

print "$url \n";
print "$output_dir \n";

my $mech = WWW::Mechanize->new();
$mech->agent_alias('Mac Safari');
$mech->get( $url );

my $html = $mech->content;

my @matches = $html =~ /https:\/\/cloud\.funda\.nl\/valentina_media\/\d+\/\d+\/\d+_2160\.jpg/g;
my %uniq = map { $_ => 1 } @matches;

print "Found ". scalar (keys %uniq ) ." images\n";

my $i = 1;
for my $u ( keys %uniq ) {
	my $filename = $output_dir.$i.'.jpg';
    getstore($u, $filename);
    print "Downloaded $i.jpg <- $u \n";

    $i++;
}

1;
