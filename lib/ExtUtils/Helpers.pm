package ExtUtils::Helpers;
use strict;
use warnings FATAL => 'all';
use Exporter 5.57 'import';

use File::Basename qw/basename dirname/;
use File::Path qw/mkpath/;
use File::Spec::Functions qw/splitpath splitdir canonpath/;
use Pod::Man;
use Module::Load;

our @EXPORT_OK = qw/build_script make_executable split_like_shell man1_pagename manify man3_pagename/;
our $VERSION = 0.010;

BEGIN {
	my $package = "ExtUtils::Helpers::" . ($^O eq 'MSWin32' ? 'Windows' : 'Unix');
	load($package);
	$package->import();
}

sub build_script {
	return $^O eq 'VMS' ? 'Build.com' : 'Build';
}

sub man1_pagename {
	my $filename = shift;
	return basename($filename).'.1';
}

my %separator = (
	MSWin32 => '.',
	VMS => '__',
	os2 => '.',
	cygwin => '.',
);

sub man3_pagename {
	my $filename = shift;
	my ($vols, $dirs, $file) = splitpath(canonpath($filename));
	$file = basename($file, qw/.pm .pod/);
	my @dirs = grep { length } splitdir($dirs);
	shift @dirs if $dirs[0] eq 'lib';
	my $separator = $separator{$^O} || '::';
	return join $separator, @dirs, "$file.3pm";
}

sub manify {
	my ($input_file, $output_file, $section, $opts) = @_;
	my $dirname = dirname($output_file);
	mkpath($dirname, $opts->{verbose}) if not -d $dirname;
	Pod::Man->new(section => $section)->parse_from_file($input_file, $output_file);
	print "Manifying $output_file\n" if $opts->{verbose} && $opts->{verbose} > 0;
	return;
}

1;



=pod

=head1 NAME

ExtUtils::Helpers - Various portability utilities for module builders

=head1 VERSION

version 0.010

=head1 SYNOPSIS

 use ExtUtils::Helpers qw/build_script make_executable split_like_shell/;

 unshift @ARGV, split_like_shell($ENV{PROGRAM_OPTS});
 write_script_to(build_script());
 make_executable(build_script());

=head1 DESCRIPTION

This module provides various portable helper functions for module building modules.

=head1 FUNCTIONS

=head2 build_script()

This function returns the appropriate name for the Build script on the local platform.

=head2 make_executable($filename)

This makes a perl script executable.

=head2 split_like_shell($string)

This function splits a string the same way as the local platform does.

=head2 man1_pagename($filename)

Returns the man page filename for a script.

=head2 man3_pagename($filename)

Returns the man page filename for a Perl library.

=head2 manify($input_filename, $output_file, $section, $opts)

Create a manpage for the script in C<$input_filename> as C<$output_file> in section C<$section>

=head1 AUTHORS

=over 4

=item *

Ken Williams <kwilliams@cpan.org>

=item *

Leon Timmermans <leont@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2004 by Ken Williams, Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

# ABSTRACT: Various portability utilities for module builders

