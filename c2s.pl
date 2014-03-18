#!/usr/bin/env perl
use strict;
use warnings;

my @input = <>;

#set status
my @lines;
my $day = '\D+';
my $num = '\d\d?';
my $time = '\d\d:\d\d';
my $user = 'Hiroaki Kadomatsu'; #replace your ID
my $status = 'task|done|run|start|stop'; #replace status that you need

for my $line (@input) {
    if ($line =~ /^\[($time)\] ($user): (.*)($status)(.*)$/) {
        push @lines, "today\t$1\t\t\t\t$4\t$3$4$5\n";
    } elsif ($line =~ /^\[($time)\] ($user): (.*)$/) {
        push @lines, "today\t$1\t\t\t\t\t$3\n";
    } elsif ($line =~ /^\[($num)月-($num) ($time)\] ($user): (.*)($status)(.*)$/) {
        push @lines, "$1/$2\t$3\t\t\t\t$6\t$5$6$7\n";
    } elsif ($line =~ /^\s+($day)($num)月 ($num), (\d{4})$/) {
        push @lines, "$4/$2/$3\t$1\n";
    } elsif ($line =~ /\[\[($day)($num)月 ($num), (\d{4})\]\]$/) {
        push @lines, "$4/$2/$3\t$1\n";
    } elsif ($line =~ /^\[($num)月-($num) ($time)\] ($user): (.*)$/) {
        push @lines, "$1/$2\t$3\t\t\t\t\t$5\n";
    } elsif ($line =~ /^\s+($num)月-.+($time)$/) {
        push @lines, "";
    } elsif ($line =~ /^$/) {
        push @lines, "";
    } elsif ($line =~ /^\s+(.*)($status)(.*)$/) {
        push @lines, "\t\t\t\t\t$2\t$1$2$3\n";
    } elsif ($line =~ /^\s+(.*)$/) {
        push @lines, "\t\t\t\t\t\t$1\n";
    } elsif ($line =~ /\n/) {
        push @lines, "";
    } else {
        push @lines, "\t\t\t\t\t\t$line\n";
    }
}

#set tags
#replace tags that you need
my $tags = 'book|buy|code|coffee|cook|desk|dish|eat|english|garbage|git|haircut|lunch|mail|maintenance|mtg|money|nail|note|perl|proofread|ruby|schola|sleep|skype|sql|supper|transcribe|uri|vacuum|vagrant|vim|wash|wish|youtube';
my (@lines2, @lines3, @lines4);
my ($lastday, $year);
my $date = '\d{4}\/\d\d?\/\d\d?';

for my $line2 (@lines) {
    my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($tags)(.*)\$";
    if ($line2 =~ /^((\d{4})\/\d\d?\/\d\d?)\t(.+)$/){
        $lastday = $1;
        $year = $2;
        if ($line2 =~ /^($date\t)日曜日 $/){
                push @lines2, "\n$1\tSunday\n";
        } elsif ($line2 =~ /^($date\t)月曜日 $/){
                push @lines2, "\n$1\tMonday\n";
        } elsif ($line2 =~ /^($date\t)火曜日 $/){
                push @lines2, "\n$1\tTuesday\n";
        } elsif ($line2 =~ /^($date\t)水曜日 $/){
                push @lines2, "\n$1\tWednesday\n";
        } elsif ($line2 =~ /^($date\t)木曜日 $/){
                push @lines2, "\n$1\tTursday\n";
        } elsif ($line2 =~ /^($date\t)金曜日 $/){
                push @lines2, "\n$1\tFriday\n";
        } elsif ($line2 =~ /^($date\t)土曜日 $/){
                push @lines2, "\n$1\tSaturday\n";
        }
    } elsif ($line2 =~ /${key}/i) {
        my $next1 = "$1\t$7\t$3\t$4\t$5\t$6$8\n";
        my $out1 = "$1\t$7\t$3\t$4\t$5\t$6$7$8\n";
        my $word = "$6$7$8";
        if ($next1 =~ /${key}/i) {
            my $next2 = "$1\t$2, $7\t$3\t$4\t$5\t$6$8\n";
            my $out2 = "$1\t$2, $7\t$3\t$4\t$5\t$word\n";
            if ($next2 =~ /${key}/i) {
                my $out3 = "$1\t$2, $7\t$3\t$4\t$5\t$word\n";
                push @lines2, "$out3";
            } else {
                push @lines2, "$out2";
            }
        } else {
            push @lines2, "$out1";
        }
    } else {
        push @lines2, "$line2";
    }
}

#set people
#replace names that you need
my $people = 'moznion|papix|boolfool|mackee_w|uzulla';
for my $line3 (@lines2) {
    my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($people)(.*)\$";
    if ($line3 =~ /${key}/i) {
        my $next1 = "$1\t$2\t$7\t$4\t$5\t$6$8\n";
        my $out1 = "$1\t$2\t$7\t$4\t$5\t$6$7$8\n";
        my $word = "$6$7$8";
        if ($next1 =~ /${key}/i) {
            my $next2 = "$1\t$2\t$3, $7\t$4\t$5\t$6$8\n";
            my $out2 = "$1\t$2\t$3, $7\t$4\t$5\t$word\n";
            if ($next2 =~ /${key}/i) {
                my $out3 = "$1\t$2\t$3, $7\t$4\t$5\t$word\n";
                push @lines3, "$out3";
            } else {
                push @lines3, "$out2";
            }
        } else {
            push @lines3, "$out1";
        }
    } else {
        push @lines3, "$line3";
    }
}

#set rate
#replace words that you need
my $rate = 'best|good|soso|bad|terrible';
for my $line4 (@lines3) {
    my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($rate)(.*)\$";
    if ($line4 =~ /${key}/i) {
        my $next1 = "$1\t$2\t$3\t$7\t$5\t$6$8\n";
        my $out1 = "$1\t$2\t$3\t$7\t$5\t$6$7$8\n";
        my $word = "$6$7$8";
        if ($next1 =~ /${key}/i) {
            my $next2 = "$1\t$2\t$3\t$4, $7\t$5\t$6$8\n";
            my $out2 = "$1\t$2\t$3\t$4, $7\t$5\t$word\n";
            if ($next2 =~ /${key}/i) {
                my $out3 = "$1\t$2\t$3\t$4, $7\t$5\t$word\n";
                push @lines4, "$out3";
            } else {
                push @lines4, "$out2";
            }
        } else {
            push @lines4, "$out1";
        }
    } else {
        push @lines4, "$line4";
    }
}

#output
print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n";

my @line5;
if (defined $lastday) {
    for my $output (@lines4) {
        if ($output =~ /^(today)(.+)$/) {
            push @line5, "$lastday$2\n";
        } elsif ($output =~ /^(\d\d?\/\d\d?)(.+)$/) {
            push @line5, "$year\/$1$2\n";
        } else {
            push @line5, "$output";
        }
    }
} else {
    for my $output (@lines4) {
        push @line5, "$output";
    }
}

for my $last (@line5) {
    if ($last =~ s/#($status|$tags)//gi) {
            print "$last";
    } elsif ($last =~ /^([^\=]*)(======)(.*)$/) {
            print "$1\n";
    } else {
        print "$last";
    }
}
