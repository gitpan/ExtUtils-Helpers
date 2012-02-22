package ExtUtils::Helpers::VMS;
{
  $ExtUtils::Helpers::VMS::VERSION = '0.014';
}
use strict;
use warnings FATAL => 'all';

use Exporter 5.57 'import';
our @EXPORT = qw/make_executable split_like_shell/;

use ExtUtils::Helpers::Unix qw/split_like_shell/; # Probably very wrong, but whatever
use File::Copy qw/copy/;

sub make_executable {
	my $filename = shift;
	my $batchname = "$filename.com";
	copy($filename, $batchname);
	ExtUtils::Helpers::Unix::make_executable($batchname);
	return;
}

# ABSTRACT: VMS specific helper bits



=pod

=head1 NAME

ExtUtils::Helpers::VMS - VMS specific helper bits

=head1 VERSION

version 0.014

=for Pod::Coverage make_executable

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

