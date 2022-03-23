#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 23 March 2022
# https://github.com/trizen

# Get the list of unsolved ProjectEuler problems and order them by difficulty.

use 5.014;
use strict;
use warnings;

use LWP::UserAgent::Cached;
use HTML::Entities qw(decode_entities encode_entities);

require LWP::UserAgent;
require HTTP::Message;

binmode(STDOUT, ':utf8');

my $problems_count = 790;

use constant {
              GET_PROBLEMS_COUNT => 0,    # true to retrieve the current number of problems
              USE_TOR_PROXY      => 0,    # true to use the Tor proxy (127.0.0.1:9050)
             };

my $cache_dir = 'cache';

if (not -d $cache_dir) {
    mkdir($cache_dir);
}

my $lwp = LWP::UserAgent::Cached->new(
    timeout       => 60,
    show_progress => 1,
    agent         => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0',
    cache_dir     => $cache_dir,
    ssl_opts      => {verify_hostname => 1, SSL_version => 'TLSv1_2'},

    nocache_if => sub {
        my ($response) = @_;
        my $code = $response->code;
        return 1 if ($code >= 500);                           # do not cache any bad response
        return 1 if ($code == 401);                           # don't cache an unauthorized response
        return 1 if ($response->request->method ne 'GET');    # cache only GET requests
        return;
    },
);

my $lwp_uc = LWP::UserAgent->new(
                                 timeout       => 60,
                                 show_progress => 1,
                                 agent    => "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0",
                                 ssl_opts => {verify_hostname => 1, SSL_version => 'TLSv1_2'},
                                );

{
    state $accepted_encodings = HTTP::Message::decodable();

    $lwp->default_header('Accept-Encoding' => $accepted_encodings);
    $lwp_uc->default_header('Accept-Encoding' => $accepted_encodings);

    require LWP::ConnCache;
    my $cache = LWP::ConnCache->new;
    $cache->total_capacity(undef);    # no limit

    $lwp->conn_cache($cache);
    $lwp_uc->conn_cache($cache);
}

if (USE_TOR_PROXY) {
    $lwp->proxy(['http', 'https'], "socks://127.0.0.1:9050");
    $lwp_uc->proxy(['http', 'https'], "socks://127.0.0.1:9050");
}

if (GET_PROBLEMS_COUNT) {

    my $content = $lwp_uc->get("https://projecteuler.net/recent")->decoded_content;

    if ($content =~ m{<td class="id_column">(\d+)</td>}) {
        $problems_count = $1 + 0;
        say ":: Found $problems_count problems.";
    }
    else {
        warn ":: Failed to extract the current number of problems.\n";
    }
}

my %solved_problems;
my @languages = ('Sidef', 'Perl', 'Julia', 'PARI GP', 'Raku', 'Go');

foreach my $lang (@languages) {
    foreach my $file (glob("$lang/*")) {
        if ($file =~ m{^\Q$lang\E/(\d+) }) {
            my $id = $1 + 0;
            $solved_problems{$id} = 1;
        }
    }
}

my $solved_count = keys %solved_problems;
say sprintf(":: Count of solved problems: %s (%.2f%% of $problems_count problems)",
            $solved_count, $solved_count / $problems_count * 100);

my @problems;

foreach my $id (1 .. $problems_count) {

    my $url     = sprintf("https://projecteuler.net/problem=%s", $id);
    my $content = $lwp->get($url)->decoded_content;

    my $difficulty;
    if ($content =~ m{\bDifficulty rating: (\d+)%}) {
        $difficulty = $1;
    }

    my $title;
    if ($content =~ m{<title>#\d+\s+(.*?) - Project Euler</title>}) {
        $title = $1;
        $title =~ s/\$(.*?)\$/$1/g;
    }
    else {
        warn "Could not extract title for problem: $url\n";
    }

    my $solve_count;
    if ($content =~ m{\bSolved by (\d+)}) {
        $solve_count = $1;
    }

    my $published;
    if ($content =~ m{\bPublished on (.*?);}) {
        $published = $1;
    }

    my %info = (
                id          => $id,
                solve_count => $solve_count,
                published   => $published,
                title       => $title,
                difficulty  => $difficulty,
               );

    push @problems, \%info;
}

my @unsolved_problems = grep { not $solved_problems{$_->{id}} } @problems;

say sprintf(":: Found %s unsolved problems", scalar(@unsolved_problems));

@problems = sort {
         (($a->{difficulty} // 'inf') <=> ($b->{difficulty} // 'inf'))
      || ($b->{solve_count} <=> $a->{solve_count})
      || ($a->{id}          <=> $b->{id})
} @problems;

open my $solved_fh,   '>:utf8', 'solved.html';
open my $unsolved_fh, '>:utf8', 'unsolved.html';

foreach my $pair (["Solved", $solved_fh], ["Unsolved", $unsolved_fh]) {

    my ($title, $fh) = @$pair;

    print $fh <<"EOF";

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>

  <head>
  <style>
  tt { font-family: monospace; font-size: 100%; }
  p.editing { font-family: monospace; margin: 10px; text-indent: -10px; word-wrap:break-word;}
  p { word-wrap: break-word; }

  table, th, td {
    border: 5px solid black;
    border-collapse: collapse;
  }

  th, td {
    border-color: #96D4D4;
  }
  </style>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <title>$title Project-Euler problems</title>
  </head>
  <body bgcolor=#ffffff>

  <table>
  <tr><th><br><strong><span> ID </span></strong><br><br></th><th> Title </th><th> Solved by </th><th> Difficulty </th></tr>
EOF
}

foreach my $problem (@problems) {
    my $row = sprintf(
                      "<tr>%s</tr>",
                      join(
                           '',
                           map { sprintf("<td>%s</td>", $_) } (
                                             $problem->{id},
                                             sprintf(
                                                     q{<a href="https://projecteuler.net/problem=%s" title="%s">%s</a>},
                                                     $problem->{id}, $problem->{published}, $problem->{title}
                                                    ),
                                             $problem->{solve_count},
                                             (defined($problem->{difficulty}) ? sprintf("%s%%", $problem->{difficulty}) : '-'),
                           )
                          )
                     );

    if ($solved_problems{$problem->{id}}) {
        say $solved_fh $row;
    }
    else {
        say $unsolved_fh $row;
    }
}

foreach my $fh ($solved_fh, $unsolved_fh) {
    say $fh "</table></body></html>";
}
