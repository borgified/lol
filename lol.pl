#!/usr/bin/env perl

use warnings;
use strict;
use Data::Dumper;

use lib './WWW-RiotGames/lib';

use WWW::RiotGames qw/set_api_key set_region get_champions get_summoner_by_name get_stats_ranked_by_id/;

my %config = do '/secret/lol.config';

set_api_key($config{'key'});
set_region($config{'region'});

print Dumper get_summoner_by_name("fwiffo");


#print Dumper get_stats_ranked_by_id('40001710');
print Dumper get_stats_ranked_by_id('565651');
